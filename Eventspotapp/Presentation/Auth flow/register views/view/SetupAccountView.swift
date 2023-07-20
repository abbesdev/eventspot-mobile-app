//
//  SetupAccountView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 13/7/2023.
//

import SwiftUI

struct Country: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let code: String
}

struct SetupAccountView: View {
    @State var fullname: String = ""
    @State var gender: String = ""
    @State var role: String = ""
    @State var birthDate = Date() // Store the selected birth date
    @State private var selectedRole = "Client"
    @State private var selectedGender = "Male"
    let roles = ["Organizer", "Client"]
    let genders = ["Male", "Female"]
    @Environment(\.presentationMode) var presentationMode
    @State private var phoneNumber = ""

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
                Text("Setup Account")
                    .font(
                        .system( size: 30)
                    )
                    .bold()
                    .padding(.horizontal)
                
                    .kerning(0.374)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                Text("Continue to add your profile informations below")
                    .font(.system( size: 18))
                    .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.horizontal)
                    .padding(.top,1)
                    .padding(.bottom,10)
                
                Text("Full name")
                    .font(
                        .system( size: 16)
                        .weight(.medium)
                    )
                    .padding(.horizontal)
                    .kerning(0.374)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                TextField("Enter your full name", text: $fullname)
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .padding(.horizontal)
                    .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                    .cornerRadius(4)
                    .padding(.horizontal)
                    .padding(.bottom,10)
                VStack {
                    Text("Birth Date")
                        .font(.system(size: 16).weight(.medium))
                        .padding(.horizontal)
                        .kerning(0.374)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    DatePicker("\(dateFormatter.string(from: birthDate))", selection: $birthDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .frame(maxWidth: .infinity, maxHeight: 48)
                        .padding(.horizontal)
                        .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                        .cornerRadius(4)
                        .padding(.horizontal)
                }
                .padding(.bottom, 10)
                VStack {
                    Text("Gender")
                        .font(.system(size: 16).weight(.medium))
                        .padding(.horizontal)
                        .kerning(0.374)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    ZStack(alignment: .trailing) {
                        Picker("", selection: $selectedGender) {
                            ForEach(genders, id: \.self) { gender in
                                Text(gender)
                                    .foregroundColor(.black)
                         
                            }
                        }
                        .accentColor(.black)
                        
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity, maxHeight: 48)
                        .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                        
                        .cornerRadius(4)
                        .padding(.horizontal)
                        
                      
                    }
                    .padding(.bottom, 10)
                    VStack {
                                Text("Phone Number")
                                    .font(.system(size: 16).weight(.medium))
                                    .padding(.horizontal)
                                    .kerning(0.374)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)

                        TextField("Enter your phone number", text: $phoneNumber)
                            .keyboardType(.numberPad)
                            .frame(maxWidth: .infinity, maxHeight: 48)
                            .padding(.horizontal)
                            .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                            .cornerRadius(4)
                            .padding(.horizontal)
                            .padding(.bottom,10)
                        

                                // Rest of your view
                            }
                    .padding(.bottom,10)
                    VStack {
                        Text("Who are you?")
                            .font(.system(size: 16).weight(.medium))
                            .padding(.horizontal)
                            .kerning(0.374)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        ZStack(alignment: .trailing) {
                            Picker("", selection: $selectedRole) {
                                ForEach(roles, id: \.self) { role in
                                    Text(role)
                                        .foregroundColor(.black)
                                    
                                }
                            }
                            .accentColor(.black)
                            
                            .pickerStyle(.menu)
                            .frame(maxWidth: .infinity, maxHeight: 48)
                            .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                            
                            .cornerRadius(4)
                            .padding(.horizontal)
                            
                            
                        }
                    }
                        .padding(.bottom, 10)
                    
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 0) {
                        Text("Continue")
                            .foregroundColor(.white)
                    }
                    
                    .frame(maxWidth: .infinity, maxHeight: 48, alignment: .center)
                    .background(Color(red: 0.88, green: 0.27, blue: 0.35))
                    .cornerRadius(4)
                    .padding()
                    //                    .disabled(registrationViewModel.username.isEmpty || registrationViewModel.email.isEmpty || registrationViewModel.password.isEmpty)
                    .onTapGesture {
                        //                        registrationViewModel.username = username
                        //                        registrationViewModel.email = email
                        //                        registrationViewModel.password = password
                        //
                        //                        registrationViewModel.register()
                        
                    }
                    
                    
                    
                }
               
                       
            }
            
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    

    
    
    }


struct SetupAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SetupAccountView()
    }
}
