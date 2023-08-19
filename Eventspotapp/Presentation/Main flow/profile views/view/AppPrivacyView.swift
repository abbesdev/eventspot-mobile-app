//
//  AppPrivacyView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 27/7/2023.
//

import SwiftUI

struct AppPrivacyView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView{
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                   
                    VStack(alignment: .leading, spacing: 20){
                        
                        Text("We at EventSpot are committed to protecting your privacy and ensuring the security of any personal information you share with us. This privacy policy outlines how we collect, use, and protect your data while using our event app.")
                            .font(.body)
                        
                        Text("Information Collection and Use")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text("EventSpot does not collect any personal data from its users. We do not require you to create an account or provide any personal information to use our app.")
                        
                        Text("Data Sharing and Third-Party Services")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text("EventSpot does not share any user data with third-party services or individuals. Your privacy is of utmost importance to us, and we do not engage in any data-sharing practices with external entities.")
                        
                        Text("User Data and App Functionality")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    Text("As we do not collect any personal data, there are no user profiles or accounts within the EventSpot app. All app functionality is designed to work without the need for any personal information.")
                    
                    Text("Anonymous Analytics")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text("EventSpot may collect anonymous analytics data to improve app performance and user experience. This data is strictly anonymous and does not include any personally identifiable information.")
                    
                    Text("Security")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text("We take the security of your data seriously. EventSpot employs industry-standard security measures to protect your information from unauthorized access, alteration, or destruction.")
                    VStack(alignment: .leading, spacing: 20){
                        Text("Contact Us")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text("If you have any questions or concerns about our app's privacy policy, please contact us at support@eventspot.com.")
                        
                        Text("Changes to Privacy Policy")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text("EventSpot reserves the right to update and modify this privacy policy as needed. Any changes will be communicated through app updates or notifications.")
                    }}
                .padding(.horizontal)
                .padding(.vertical, 20)
                
            }
            .navigationBarTitle("App Privacy Policy")
            .navigationBarItems(leading: Button("Cancel"){
               presentationMode.wrappedValue.dismiss()

           })
        }
    }
}

struct AppPrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        AppPrivacyView()
    }
}
