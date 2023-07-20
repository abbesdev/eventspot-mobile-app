//
//  ProfileView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 14/7/2023.
//

import SwiftUI

struct ProfileView: View {
    // Sample user data for demonstration purposes
    @State private var userFullName = "John Doe"
    @State private var userEmail = "john.doe@example.com"
    @State private var userRole = "normal user"
    @State private var userAvatar = "user_avatar_placeholder" // Replace with the URL or image name of the avatar
    @State private var userPreferences: [String] = ["Music", "Food", "Sports"]
    @State private var notificationEnabled = false
    @State private var invitesEnabled = false
    @State private var isProfileEditSheetPresented = false // Track whether the sheet is presented

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                        ProfileHeaderView(
                            userFullName: $userFullName,
                            userEmail: $userEmail,
                            userRole: $userRole,
                            userAvatar: $userAvatar
                        )
                        .frame(maxWidth: .infinity)
                    Divider()
                    ProfileSettingsView(notificationEnabled: $notificationEnabled, invitesEnabled: $invitesEnabled)
                    Divider()
                    VStack(alignment: .leading, spacing: 20) {
                        Text("User profile")
                            .font(.headline)
                        HStack{
                            Button("Edit Profile", action: {
                                isProfileEditSheetPresented.toggle()
                            })
                            .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                        HStack{
                            Button("Change password", action: {
                                isProfileEditSheetPresented.toggle()
                            })
                            .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                        HStack{
                            Button("Switch to organizer", action: {
                                isProfileEditSheetPresented.toggle()
                            })
                            .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                    }
                    Divider()
                    Text("User profile")
                        .font(.headline)
                    HStack{
                        Button("App privacy", action: {
                            isProfileEditSheetPresented.toggle()
                        })
                        .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "chevron.right")
                                                .foregroundColor(.black)
                    }
                    HStack{
                        Button("Log out", action: {
                            isProfileEditSheetPresented.toggle()
                        })
                        .foregroundColor(.red)
                        Spacer()
                        Image(systemName: "door.left.hand.open")
                                                .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("Profile", displayMode: .large)
            .sheet(isPresented: $isProfileEditSheetPresented) {
                            ProfileEditView()
                        }
        }
    }
}

struct ProfileHeaderView: View {
    @Binding var userFullName: String
    @Binding var userEmail: String
    @Binding var userRole: String
    @Binding var userAvatar: String
    
    var body: some View {
        ScrollView{
            VStack(spacing: 10) {
                Image(systemName:"person.fill") // Assuming "avatar" is a URL or image name
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                Text(userFullName)
                    .font(.headline)
                Text(userEmail)
                    .foregroundColor(.gray)
                Text(userRole)
                    .foregroundColor(.blue)
            }
        }
    }
}



struct ProfileSettingsView: View {
    @Binding var notificationEnabled: Bool
    @Binding var invitesEnabled: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Profile Settings")
                .font(.headline)
            
            Toggle("Enable Notifications", isOn: $notificationEnabled)
                .padding(.vertical, 5)
            Toggle("Open to invites", isOn: $invitesEnabled)
                .padding(.vertical, 5)
           
        }
        .padding(.top)
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct ProfileEditView: View {
    // Properties to hold the edited profile data
    @State private var editedFullName = ""
    @State private var editedEmail = ""
    // Add more properties for other editable data like phoneNumber, gender, etc.
    
    var body: some View {
        Form {
            Section(header: Text("Edit Profile")) {
                TextField("Full Name", text: $editedFullName)
                TextField("Email", text: $editedEmail)
                // Add more TextField for other editable data
            }
            
            Button("Save Changes") {
                // Handle saving changes here
                // You can update the user data in your backend or user authentication system with the edited values
            }
        }
        .padding()
    }
}
