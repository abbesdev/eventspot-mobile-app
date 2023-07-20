//
//  RegistrationViewModel.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 12/7/2023.
//

import SwiftUI

class RegistrationViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var role = "normal user"
    @Published var isRegistered = false
    @Published var errorMessage = ""
    
    func register() {
        // Perform the API call to register the user with the provided details
        // You can use URLSession or Alamofire to handle the API request
        
        // Construct the request body
        let requestBody: [String: Any] = [
            "username": username,
            "email": email,
            "password": password,
            "role": role
        ]
        
        guard let url = URL(string: "http://localhost:3000/api/signup") else {
            self.errorMessage = "Invalid API endpoint"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Set Content-Type header

        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            self.errorMessage = "Failed to serialize request body"
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    self.errorMessage = "Invalid response"
                    return
                }
                
                if (200...299).contains(httpResponse.statusCode) {
                    // Registration successful
                    self.isRegistered = true

                } else {
                    // Registration failed
                    if let data = data, let errorMessage = String(data: data, encoding: .utf8) {
                        self.errorMessage = "Registration failed. Please try again. Error: \(errorMessage)"
                    } else {
                        self.errorMessage = "Registration failed. Please try again."
                    }
                }

            }
        }.resume()
    }
}
