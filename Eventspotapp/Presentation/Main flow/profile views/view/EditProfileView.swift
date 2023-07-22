//
//  EditProfileView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 22/7/2023.
//

import SwiftUI

struct EditProfileView: View {
    var body: some View {
        NavigationView{
            VStack{
                
            } .navigationTitle("Edit Profile")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button("Save"){})
                .navigationBarItems(leading: Button("Cancel"){})
        }
        
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
