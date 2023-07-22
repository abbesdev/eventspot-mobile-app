//
//  OrderResponse.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 21/7/2023.
//

import Foundation

import Foundation

struct OrderResponse: Codable, Identifiable {
    let id: String
    let eventId: EventR
    let ticketType: String
    let ticketPrice: Int
    let buyer: String

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case eventId
        case ticketType
        case ticketPrice
        case buyer

        
    }
  
}

struct EventR: Codable {
    let id: String
    let title: String
    let locationLatitude: Double
    let locationLongitude: Double
    let startDate: String
    let image: String
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case locationLatitude
        case locationLongitude
        case startDate
        case image
        
    }
    private static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            return formatter
        }()

        var startDate1: Date {
            return EventR.dateFormatter.date(from: startDate) ?? Date()
        }
}
