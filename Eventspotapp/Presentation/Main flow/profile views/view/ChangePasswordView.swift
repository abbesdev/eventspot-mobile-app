//
//  ChangePasswordView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 22/7/2023.
//

import SwiftUI
import Combine

struct ChangePasswordView: View {
    @State private var passwordOld : String = ""
    @State private var passwordNew : String = ""
    @State private var isUpdatingPassword = false
    @State private var updatePasswordSuccess = false
    @State private var updatePasswordError: String?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView{
            VStack{
                Text("Old Password")
                    .font(
                        .system( size: 16)
                        .weight(.medium)
                    )
                    .padding(.horizontal)
                    .kerning(0.374)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                ZStack(alignment: .trailing) {
                    SecureField("Enter your old password", text: $passwordOld)
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .padding(.horizontal)
                        .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                        .cornerRadius(4)
                        .padding(.horizontal)
                    Button(action: {
                    }) {
                        Image("eye").resizable()
                    }
                    .frame(width: 25, height: 25)
                    .padding(.trailing, 30)
                    
                }
                .padding(.bottom,10)
                Text("New password")
                    .font(
                        .system( size: 16)
                        .weight(.medium)
                    )
                    .padding(.horizontal)
                    .kerning(0.374)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                ZStack(alignment: .trailing) {
                    SecureField("Enter your new password", text: $passwordNew)
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .padding(.horizontal)
                        .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                        .cornerRadius(4)
                        .padding(.horizontal)
                    Button(action: {
                    }) {
                        Image("eye").resizable()
                    }
                    .frame(width: 25, height: 25)
                    .padding(.trailing, 30)
                    
                }
                .padding(.bottom,10)
                Spacer()
            } .navigationTitle("Change password")
                .navigationBarTitleDisplayMode(.large)
                .navigationBarItems(trailing: Button("Save"){     updatePassword()
                    
                    
                })
                .navigationBarItems(leading: Button("Cancel"){
                    presentationMode.wrappedValue.dismiss()

                })
                .padding(.top,20)
                .alert(isPresented: $updatePasswordSuccess) {
                          Alert(title: Text("Success"), message: Text("Password updated successfully!"), dismissButton: .default(Text("OK")))
                      }
                      .alert(isPresented: Binding<Bool>(get: { updatePasswordError != nil }, set: { _ in updatePasswordError = nil })) {
                          Alert(title: Text("Error"), message: Text(updatePasswordError ?? ""), dismissButton: .default(Text("OK")))
                      }

        }
    }
    private func updatePassword() {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            print("User ID not found in UserDefaults.")
            return
        }

        let urlString = "\(BASE_URL)api/update-password/\(userId)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            return
        }

        // Prepare the request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Prepare the request body
        let requestBody: [String: String] = [
            "oldPassword": passwordOld,
            "newPassword": passwordNew
        ]

        // Convert the request body to JSON data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) else {
            print("Error converting data to JSON.")
            return
        }

        request.httpBody = jsonData

        // Make the API request
        isUpdatingPassword = true
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isUpdatingPassword = false

                if let error = error {
                    updatePasswordError = "Failed to update password: \(error.localizedDescription)"
                } else {
                    // Check the response status code to see if the update was successful
                    if let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) {
                        updatePasswordSuccess = true
                        presentationMode.wrappedValue.dismiss()

                    } else {
                        updatePasswordError = "Failed to update password. Please check your old password.\(response.debugDescription)"
                    }
                }
            }
        }.resume()
    }

}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
