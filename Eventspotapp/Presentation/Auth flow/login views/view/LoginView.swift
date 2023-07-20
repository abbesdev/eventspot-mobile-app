//
//  LoginView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 14/7/2023.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State private var isChecked = false
    @StateObject private var loginViewModel = LoginViewModel() // Add LoginViewModel instance

    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            
            VStack{
                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("barr") // Replace with your image name or URL
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18) // Adjust the size of the image
                            .foregroundColor(.blue) // Change the color of the image as desired
                            .padding(14)
                            .overlay(
                                Circle()
                                
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 0.5)
                            )
                            .padding(.horizontal)
                            .padding(.bottom,8)
                        Spacer()
                    }
                }
                Text("Login")
                    .font(
                        .system( size: 30)
                    )
                    .bold()
                    .padding(.horizontal)
                
                    .kerning(0.374)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                Text("Join a community of events worldwide to experience seamless experience")
                    .font(.system( size: 18))
                    .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.horizontal)
                    .padding(.top,1)
                    .padding(.bottom,10)
                
                
                
                VStack{
                    Text("Email address")
                        .font(
                            .system( size: 16)
                            .weight(.medium)
                        )
                        .padding(.horizontal)
                        .kerning(0.374)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    TextField("Enter your email address", text: $email)
                        .frame(maxWidth: .infinity, maxHeight: 48)
                        .padding(.horizontal)
                        .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                        .cornerRadius(4)
                        .padding(.horizontal)
                        .padding(.bottom,10)
                    
                }
                VStack{
                    Text("Password")
                        .font(
                            .system( size: 16)
                            .weight(.medium)
                        )
                        .padding(.horizontal)
                        .kerning(0.374)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    ZStack(alignment: .trailing) {
                        SecureField("Enter your password", text: $password)
                            .frame(maxWidth: .infinity, maxHeight: 48)
                            .padding(.horizontal)
                            .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                            .cornerRadius(4)
                            .padding(.horizontal)
                        Button(action: {
                        }) {
                            Image("eye").resizable()
                        }
                        .frame(width: 25, height: 25)
                        .padding(.trailing, 30)
                        
                    }
                    .padding(.bottom,10)
                    
                }
                
                Button(action: {
                    isChecked.toggle()
                }) {
                    
                    if isChecked {
                        Image(systemName: "checkmark.square.fill")
                            .foregroundColor(.red)
                    } else {
                        Image(systemName: "square")
                            .foregroundColor(.gray)
                    }
                    Text("Remember me")
                        .foregroundColor(.gray)
                        .font(.system(size:16))
                        .multilineTextAlignment(.leading)
                    
                }
                .padding()
                .frame(maxWidth:.infinity, alignment: .leading)
                Spacer()
                
                HStack(alignment: .center, spacing: 0) {
                                  Button(action: {
                                      print("button clicked")
                                      loginViewModel.email = email
                                      loginViewModel.password = password
                                      loginViewModel.login() // Call the login function from the ViewModel
                                  }) {
                                      Text("Login")
                                          .foregroundColor(.white)
                                  }
                              }
                
                .frame(maxWidth: .infinity, maxHeight: 48, alignment: .center)
                .background(Color(red: 0.88, green: 0.27, blue: 0.35))
                .cornerRadius(4)
                .padding(.horizontal)
                HStack(alignment: .center, spacing: 0) {
                    Text("Create an acccount")
                        .foregroundColor(.black)
                }
                
                .frame(maxWidth: .infinity, maxHeight: 48, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .background(Color.white)
                .padding(.horizontal)
                .padding(.bottom,14)
                //                    .disabled(registrationViewModel.username.isEmpty || registrationViewModel.email.isEmpty || registrationViewModel.password.isEmpty)
                //                    .onTapGesture {
                //                        registrationViewModel.username = username
                //                        registrationViewModel.email = email
                //                        registrationViewModel.password = password
                //
                //                        registrationViewModel.register()
                //
                //                    }
                
                Text("Forgot your password ? Reset it here")
                    .font(
                        Font.custom("SF Pro Text", size: 16)
                            .weight(.medium)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.17))
                
            }.onAppear {
                print("DashboardView onAppear called. Fetching events...")
                loginViewModel.login()
            }
            .background(
                NavigationLink(destination: MainView().navigationBarBackButtonHidden(true), isActive: $loginViewModel.isLoggedIn) {
                            EmptyView()
                        }
                    )
        }
        
        
        //            .alert(isPresented: Binding(
        //                get: { registrationViewModel.errorMessage != "" },
        //                set: { _ in registrationViewModel.errorMessage = "" }
        //            )) {
        //                Alert(title: Text("Error"), message: Text(registrationViewModel.errorMessage), dismissButton: .default(Text("OK")))
        //            }
        //            .background(
        //                          NavigationLink(
        //                              destination: OtpView()
        //                                .navigationBarBackButtonHidden(true)
        //,
        //                              isActive: $isRegistered,
        //                              label: { EmptyView() }
        //                          )
        //                      )
        //              .onReceive(registrationViewModel.$isRegistered) { value in
        //                  if value {
        //                      isRegistered = true
        //                  }
        //              }
        .navigationBarHidden(true)
    
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
