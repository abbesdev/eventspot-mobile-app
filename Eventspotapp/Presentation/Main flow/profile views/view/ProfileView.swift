//
//  ProfileView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 14/7/2023.
//

import SwiftUI
import URLImage
import Combine


struct ProfileView: View {
    @ObservedObject var  profileViewmodel = ProfileViewModel()

    // Sample user data for demonstration purposes
    @State private var userFullName = "John Doe"
    @State private var userEmail = "john.doe@example.com"
    @State private var userRole = "normal user"
    @State private var userAvatar = "user_avatar_placeholder" // Replace with the URL or image name of the avatar

   @State private var notificationEnabled = false
    @State private var isProfileEditSheetPresented = false // Track whether the sheet is presented
    @State private var isPasswordSheetPresented = false // Track whether the sheet is presented
    @State private var isAppPrivacySheetPresented = false // Track whether the sheet is presented

    var body: some View {

        NavigationView {
            
            ScrollView {
              
                VStack(alignment: .leading, spacing: 20) {
                        ProfileHeaderView(
                            userFullName:$userFullName,
                            userEmail: $userEmail,
                            userRole: $userRole,
                            userAvatar: $userAvatar
                        )
                        .frame(maxWidth: .infinity)
                    Divider()
                    ProfileSettingsView(notificationEnabled: $notificationEnabled)
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
                                isPasswordSheetPresented.toggle()
                            })
                            .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.black)
                        }
                       
                    }
                    Divider()
                    Text("App usage")
                        .font(.headline)
                    HStack{
                        Button("App privacy", action: {
                            isAppPrivacySheetPresented.toggle()
                        })
                        .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "chevron.right")
                                                .foregroundColor(.black)
                    }
                    .onTapGesture {
                    }
                    HStack{
                        Button("Log out", action: {
                           
                                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                            
                               })
                        .foregroundColor(.red)
                        Spacer()
                        Image(systemName: "door.left.hand.open")
                                                .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom,30)
            }
            .navigationBarTitle("Profile", displayMode: .large)
          
            .sheet(isPresented: $isProfileEditSheetPresented) {
                EditProfileView()
                    .onDisappear {
                                           // Refresh user data when returning from EditProfileView
                                           profileViewmodel.fetchUserByID(completion: { _ in })
                                       }
                               }
                               .onAppear {
                                   // Fetch user data when the ProfileView is entered
                                   profileViewmodel.fetchUserByID(completion: { _ in })
                               }
            .sheet(isPresented: $isPasswordSheetPresented) {
                            ChangePasswordView()
                        }
            .sheet(isPresented: $isAppPrivacySheetPresented) {
                            AppPrivacyView()
                        }
         
            
        }

          }
}

struct ProfileHeaderView: View {
    @Binding var userFullName: String
    @Binding var userEmail: String
    @Binding var userRole: String
    @Binding var userAvatar: String
    @ObservedObject var  profileViewmodel = ProfileViewModel()

    var body: some View {
        ScrollView{
            VStack(spacing: 10) { 
                URLImage( URL(string: profileViewmodel.user?.avatar ?? "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930") ?? URL(string: "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930")!) { image in
                                 image
                                     .resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .frame(width: 100, height: 100)
                                     .cornerRadius(500)
                                     .padding(10)
                             }
                
                Text("\(profileViewmodel.user?.username ?? "Loading username")")
                    .font(.headline)
                Text("\(profileViewmodel.user?.role ?? "Loading user role")")
                    .font(.subheadline)
               
            }
            .padding(.vertical)
            
        }

       
    }
}



struct ProfileSettingsView: View {
    @Binding var notificationEnabled: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Profile Settings")
                .font(.headline)
            
            Toggle("Enable Notifications", isOn: $notificationEnabled)
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

