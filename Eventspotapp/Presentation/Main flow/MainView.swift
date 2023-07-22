//
//  MainView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 14/7/2023.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    @State private var userRole = "normal user" // Replace this with your method to get the user's role
  
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home view
            DashboardView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            
            // Events view
        if userRole == "normal user" {
              LockedView()
                  .tabItem {
                      Image(systemName: "lines.measurement.horizontal")
                      Text("My events")
                  }
                  .tag(1)
            }
                      
        if userRole == "organizer" {
                EventView()
                    .tabItem {
                        Image(systemName: "lines.measurement.horizontal")
                        Text("My events")
                    }
                    .tag(1)
                
                
            }
            // Tickets view
            TicketView()
                .tabItem {
                    Image(systemName: "ticket")
                    Text("Tickets")
                }
                .tag(2)
            
            // Profile view
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(3)
        }
        .accentColor(Color(red: 0.88, green: 0.27, blue: 0.35))
        .onAppear {
                   // Load user's role from UserDefaults or any other method
                   if let savedRole = UserDefaults.standard.string(forKey: "userRole") {
                       userRole = savedRole
                   }
               }


    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
