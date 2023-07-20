//
//  Event.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 17/7/2023.
//
import Foundation

// Define a struct that represents the Ticket data structure
struct Ticket: Codable, Identifiable {
    let id: String
    let type: String
    let price: Double
    let quantity: Int
}

// Define a struct that represents the Event data structure
struct Event: Codable, Identifiable {
    let id: String
    let image: String
    let title: String
    let description: String
    let location: String
    let startDate: Date
    let endDate: Date
    let organizer: String // Assuming the organizer is represented by their username or some unique identifier
    let category: String
    let tickets: [Ticket]
    let createdAt: Date
    let updatedAt: Date
}


