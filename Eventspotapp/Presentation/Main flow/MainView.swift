//
//  MainView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 14/7/2023.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    
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
            EventView()
                .tabItem {
                    Image(systemName: "lines.measurement.horizontal")
                    Text("My events")
                }
                .tag(1)
            
          
            
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
        .accentColor(.blue)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
