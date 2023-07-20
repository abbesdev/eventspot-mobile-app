//
//  DashboardViewModel.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 17/7/2023.
//

import Foundation
import Combine

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    return formatter
}()
class EventViewModel: ObservableObject {
    @Published var events = [EventResponse]()

    private var cancellable: AnyCancellable?

    init() {
        fetchDataEvents { _ in }
    }

    func fetchDataEvents(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:3000/api/events/") else {
            fatalError("Invalid URL")
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(false)
                return
            }

            guard let data = data else {
                print("No data returned from API")
                completion(false)
                return
            }

            do {
                let decodedData = try JSONDecoder().decode([EventResponse].self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.events = decodedData
                    completion(true)
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(false)
            }
        }.resume()
       
    }
}
