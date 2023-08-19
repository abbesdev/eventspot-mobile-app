//
//  MembershipDetailsView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 28/7/2023.
//

import SwiftUI

import SwiftUI

struct MembershipDetailsSheet: View {
    // Membership details properties here (you can pass them through the initializer)
    var membershipName: String
    var membershipDescription: String
    var price: String
    // Other membership properties

    @Binding var isPresented: Bool // Binding to control the sheet presentation

    var body: some View {
        VStack {
            Text(membershipName)
                .font(.headline)
            Text(membershipDescription)
                .font(.subheadline)
            // Display other membership details here
            
            // Payment confirmation button
            Button("Confirm Payment") {
                // Implement the payment confirmation logic here
                // After payment is confirmed, you can dismiss the sheet
                isPresented = false
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .padding()
    }
}
