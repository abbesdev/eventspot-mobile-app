//
//  LoginResponse.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 18/7/2023.
//

import Foundation

struct UserResponse: Codable {    
    let message: String
    let token: String
    let user: User
    
    private enum CodingKeys: String, CodingKey {
        case message
        case token
        case user
    }
}

struct User: Codable {
    let id: String
    let avatar: String
    let username: String
    let email: String
    let fullName: String
    let password: String
    let role: String
    let otpCode: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case avatar
        case username
        case email
        case fullName
        case password
        case role
        case otpCode
        
    }
}

