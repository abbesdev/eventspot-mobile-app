//
//  EditProfileView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 22/7/2023.
//

import SwiftUI

struct EditProfileView: View {
    @State var editedFullname: String = ""
    @State var bD: String = ""
    @State var editedUsername: String = ""
    @State var editedGender: String = "Male"
    @State var editedPhone: String = ""
    @State var editedBirthDate = Date() // Store the selected birth date
    let genders = ["Male", "Female"]

    @ObservedObject var  profileViewmodel = ProfileViewModel()

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView{
            VStack{
                TextField(profileViewmodel.user?.fullName ?? "Enter your full name", text: $editedFullname)
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .padding(.horizontal)
                    .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    .padding(.top,20)
                TextField(profileViewmodel.user?.username ?? "", text: $editedUsername)
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .padding(.horizontal)
                    .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    .padding(.top,4)
                DatePicker( bD, selection: $editedBirthDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .padding(.horizontal)
                    .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                    .cornerRadius(4)
                    .padding(.horizontal)
                    .padding(.top,4)
                    .onAppear {
                        // Parse the date string from the backend to a Date object
                        if let date = dateFormatter.date(from: (profileViewmodel.user?.birthDate) ?? "") {
                           let test =  date.description.prefix(10)
                            bD = "\(test)"
                        }
                    }
                  




                TextField(profileViewmodel.user?.phoneNumber ?? "", text: $editedPhone)
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .padding(.horizontal)
                    .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    .padding(.top,4)
                ZStack(alignment: .trailing) {
                    Picker("", selection: $editedGender) {
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
                .padding(.top, 4)
                Spacer()
               
               
            } .navigationTitle("Edit Profile")
                .navigationBarTitleDisplayMode(.large)
                .navigationBarItems(
                    trailing: Button("Save") {
                        profileViewmodel.updateUserProfile(
                            fullname: editedFullname.isEmpty ? nil : editedFullname,
                            username: editedUsername.isEmpty ? nil : editedUsername,
                            birthdate: dateFormatter.string(from: editedBirthDate),
                            gender: editedGender.isEmpty ? nil : editedGender,
                            phone: editedPhone.isEmpty ? nil : editedPhone
                        ) { success in
                            if success {
                                print("Profile updated successfully!")
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                print("Failed to update profile.")
                                // You can show an error message or take any other appropriate action here.
                            }
                        }
                    }
                )              .navigationBarItems(leading: Button("Cancel"){
                    presentationMode.wrappedValue.dismiss()

                })
        }
        
    }
    private let dateOnlyFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
