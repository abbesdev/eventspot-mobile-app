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

    var body: some View {
        VStack{
            Image("b_arrow")
                .frame(maxWidth: .infinity, maxHeight: 33.33333, alignment: .topLeading)
                .padding()
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
                HStack(alignment: .center, spacing: 0) { Text("Create account")
                        .foregroundColor(.white)
                }

                .frame(maxWidth : .infinity, maxHeight: 48, alignment: .center)
                .background(Color(red: 0.88, green: 0.27, blue: 0.35))
                .cornerRadius(4)
                .padding()
                .onTapGesture {
                    
                }
                Text("Already registered in the app? Login")
                  .font(
                    Font.custom("SF Pro Text", size: 16)
                      .weight(.medium)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.17))

            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
