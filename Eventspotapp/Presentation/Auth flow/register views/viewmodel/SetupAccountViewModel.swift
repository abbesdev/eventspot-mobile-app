//
//  SetupAccountViewModel.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 13/7/2023.
//

import SwiftUI

class SetupAccountViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var birthDate = ""
    @Published var gender = ""
    @Published var phoneNumber = ""
    @Published var role = ""

    @Published var errorMessage = ""
    
    
    func updateUserByID(id: String) {
        // Perform the API call to update the user with the provided ID
        // You can use URLSession or Alamofire to handle the API request

        let requestBody: [String: Any] =
        [
            "fullName": fullName,
            "birthDate": birthDate,
            "gender": gender,
            "phoneNumber": phoneNumber,
            "role": role
        ]

        guard let url = URL(string: "http://localhost:3000/api/users/\(id)") else {
            self.errorMessage = "Invalid API endpoint"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
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
                    // Update successful

                } else {
                    // Update failed
                    if let data = data, let errorMessage = String(data: data, encoding: .utf8) {
                        self.errorMessage = "Update failed. Please try again. Error: \(errorMessage)"
                    } else {
                        self.errorMessage = "Update failed. Please try again."
                    }
                }
            }
        }.resume()
    }
}
