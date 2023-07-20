//
//  Splash_screen.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 12/7/2023.
//

import SwiftUI

struct Splash_screen: View {
    @State private var fadeOut = false
    @State private var navigateToNextView = false

    var body: some View {
        NavigationView {
            ZStack {
                Image("logo")
                    .opacity(fadeOut ? 0 : 1)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        navigateToNextView = true
                    }
                }
            }
            .background(
                NavigationLink(destination: destinationView(), isActive: $navigateToNextView) {
                    EmptyView()
                }
            )
            .navigationBarHidden(true)
        }
    }
    
    // Determine the destination view based on user login and app installation status
    private func destinationView() -> some View {
        // Check if the user is already logged in
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        if isLoggedIn {
            return AnyView(MainView().navigationBarBackButtonHidden(true))
        }
        
        // Check if the app has been opened before
        let hasBeenOpenedBefore = UserDefaults.standard.bool(forKey: "hasBeenOpenedBefore")
        if hasBeenOpenedBefore {
            return AnyView(LoginView().navigationBarBackButtonHidden(true))
        } else {
            // Set the flag to indicate that the app has been opened before
            UserDefaults.standard.set(true, forKey: "hasBeenOpenedBefore")
            return AnyView(WelcomeView().navigationBarBackButtonHidden(true))
        }
    }
}

struct Splash_screen_Previews: PreviewProvider {
    static var previews: some View {
        Splash_screen()
    }
}
