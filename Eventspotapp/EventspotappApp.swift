//
//  EventspotappApp.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 12/7/2023.
//

import SwiftUI
import Stripe

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        StripeAPI.defaultPublishableKey = "pk_test_51N9Ig9G5zDITVHmrr02si8H1mI8FozT81yIF4xX8Nskdvrpd2TP8YWZJnsVKlY4OSGrbq9eDuAc5gwddrtyDZ4os00WgL7grRs"
        return true
    }
}

@main
struct EventspotappApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            Splash_screen()

        }
    }
}
