//
//  RegisterView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 12/7/2023.
//

import SwiftUI

struct RegisterView: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var password2: String = ""
    @State private var isChecked = false
    @StateObject private var registrationViewModel = RegistrationViewModel()
    @State private var isRegistered = false
    @State private var isAlreadyRegistered = false
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
                Text("Create an account")
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
                
                Text("Username")
                    .font(
                        .system( size: 16)
                        .weight(.medium)
                    )
                    .padding(.horizontal)
                    .kerning(0.374)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                TextField("Enter your username", text: $username)
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .padding(.horizontal)
                    .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                    .cornerRadius(4)
                    .padding(.horizontal)
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
                VStack{
                    Text("Confirm Password")
                        .font(
                            .system( size: 16)
                            .weight(.medium)
                        )
                        .padding(.horizontal)
                        .kerning(0.374)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    ZStack(alignment: .trailing) {
                        SecureField("Enter your password", text: $password2)
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
                        Text("Agree to the terms & conditions")
                            .foregroundColor(.gray)
                            .font(.system(size:16))
                            .multilineTextAlignment(.leading)
                        
                    }
                    .padding()
                    .frame(maxWidth:.infinity, alignment: .leading)
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 0) {
                        Text("Create account")
                            .foregroundColor(.white)
                    }
                    
                    .frame(maxWidth: .infinity, maxHeight: 48, alignment: .center)
                    .background(Color(red: 0.88, green: 0.27, blue: 0.35))
                    .cornerRadius(4)
                    .padding()
                    .disabled(registrationViewModel.username.isEmpty || registrationViewModel.email.isEmpty || registrationViewModel.password.isEmpty)
                    .onTapGesture {
                        registrationViewModel.username = username
                        registrationViewModel.email = email
                        registrationViewModel.password = password
                        
                        registrationViewModel.register()
                        
                    }
                    HStack{
                        Text("Already registered in the app?")
                            .font(
                                .system( size: 16)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.17))
                        Text("Login")
                            .font(
                                .system( size: 16)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.97, green: 0.15, blue: 0.17))
                    }
                    .onTapGesture {
                        isAlreadyRegistered = true
                    }
                }
            }
            
            .alert(isPresented: Binding(
                get: { registrationViewModel.errorMessage != "" },
                set: { _ in registrationViewModel.errorMessage = "" }
            )) {
                Alert(title: Text("Error"), message: Text(registrationViewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
            .background(
                          NavigationLink(
                              destination: OtpView()
                                .navigationBarBackButtonHidden(true)
,
                              isActive: $isRegistered,
                              label: { EmptyView() }
                          )
                          )

              .onReceive(registrationViewModel.$isRegistered) { value in
                  if value {
                      isRegistered = true
                  }
              }
              .navigationBarHidden(true)
          }
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
