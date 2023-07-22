//
//  EventResponse.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 17/7/2023.
//

import Foundation

struct EventResponse: Codable, Identifiable {
    let id: String
    let title: String
    let image: String
    let description: String
    let locationLatitude: Double
    let locationLongitude: Double
    let startDate: String
    let endDate: String
    let organizer: String
    let category: String
    let tickets: [TicketRR]

    let v: Int
    private static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            return formatter
        }()

        var startDate1: Date {
            return EventResponse.dateFormatter.date(from: startDate) ?? Date()
        }
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case image
        case description
        case locationLatitude
        case locationLongitude
        case startDate
        case endDate
        case organizer
        case category
        case tickets

        case v = "__v"
    }
}

struct TicketRR: Codable {
    let id: String
    let type: String
    let price: Double
    let quantity: Int

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type
        case price
        case quantity
    }
}
