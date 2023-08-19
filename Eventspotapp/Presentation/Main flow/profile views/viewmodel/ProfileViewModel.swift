//
//  ProfileViewModel.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 22/7/2023.
//

import SwiftUI
import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: UserProfileResponse?
    init() {
   
        fetchUserByID { _ in }
    }
    func fetchUserByID(completion: @escaping (Bool) -> Void) {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            print("User ID not found in UserDefaults.")
            return
        }
        
        let urlString = "\(BASE_URL)api/users/\(userId)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            return
        }
        
        print("userid decoding JSON: \(userId)")

        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            print("Received data: \(String(data: data, encoding: .utf8) ?? "No data")")

            do {
                let decodedData = try JSONDecoder().decode(UserProfileResponse.self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.user = decodedData
                    completion(true)
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(false)
            }
        }.resume()
    }
    
    func updateUserProfile(fullname: String?, username: String?, birthdate: String?, gender: String?, phone: String?, completion: @escaping (Bool) -> Void) {
         guard let userId = UserDefaults.standard.string(forKey: "userId") else {
             print("User ID not found in UserDefaults.")
             completion(false)
             return
         }
         
         guard let url = URL(string: "\(BASE_URL)api/users/\(userId)") else {
             print("Invalid URL.")
             completion(false)
             return
         }
         
         var request = URLRequest(url: url)
         request.httpMethod = "PUT"
         
        // Create a dictionary to represent the updated user profile data
               var updatedProfile: [String: Any] = [:]
               
               // Check if the fields are not nil and add them to the dictionary
               if let fullname = fullname { updatedProfile["fullName"] = fullname }
               if let username = username { updatedProfile["username"] = username }
               if let birthdate = birthdate { updatedProfile["birthDate"] = birthdate }
               if let gender = gender { updatedProfile["gender"] = gender }
               if let phone = phone { updatedProfile["phoneNumber"] = phone }
         
         // Convert the dictionary to JSON data
         do {
             let jsonData = try JSONSerialization.data(withJSONObject: updatedProfile, options: [])
             request.httpBody = jsonData
             request.setValue("application/json", forHTTPHeaderField: "Content-Type")
             
             URLSession.shared.dataTask(with: request) { data, response, error in
                 if let error = error {
                     print("Error: \(error)")
                     completion(false)
                     return
                 }
                 
                 // Check the response status code to see if the update was successful
                 if let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) {
                     print("Profile updated successfully!")
                     // You can also update the local user profile here if needed.
                     completion(true)
                 } else {
                     print("Failed to update profile. Status code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
                     completion(false)
                 }
             }.resume()
         } catch {
             print("Error converting data to JSON: \(error)")
             completion(false)
         }
     }
}
struct UserProfileResponse: Codable {
    let id: String
    let username: String
    let email: String
    let password: String
    let role: String
    let avatar: String
    let phoneNumber: String?
    let gender: String?
    let birthDate: String?
    let fullName: String?
    let otpCode: String
    let version: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username, email, password, role, avatar, phoneNumber, gender, birthDate, fullName, otpCode, version = "__v"
    }
}

