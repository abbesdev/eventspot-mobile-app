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
    @Published var eventsR = [EventResponse]()
    @Published var events = [EventResponse]()
    @Published var eventsByOrganizerId = [EventResponse]()

    private var cancellable: AnyCancellable?

    init() {
        fetchDataEvents { _ in }
        fetchDataEventsByOrganizerID { _ in }
        fetchEvents { _ in }
    }
    func fetchEvents(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(BASE_URL)api/events/") else {
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
                DispatchQueue.main.async {
                    self.eventsR = decodedData
                    completion(true)
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(false)
            }
        }.resume()
       
    }
    
    func fetchDataEvents(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(BASE_URL)api/events/") else {
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
    func fetchDataEventsByOrganizerID(completion: @escaping (Bool) -> Void) {
        

        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
return
        }

           let urlString = "\(BASE_URL)api/events/organizer/\(userId)"

        guard let url = URL(string: urlString) else {
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
                    self.eventsByOrganizerId = decodedData
                    completion(true)
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(false)
            }
        }.resume()
      
       
    }
    func addNewEvent(event: EventCreateModel, completion: @escaping (Bool) -> Void) {
          guard let url = URL(string: "\(BASE_URL)api/events") else {
              print("Invalid URL")
              completion(false)
              return
          }
          
          var request = URLRequest(url: url)
          request.httpMethod = "POST"
          request.addValue("application/json", forHTTPHeaderField: "Content-Type")
          
          do {
              let jsonData = try JSONEncoder().encode(event)
              request.httpBody = jsonData
          } catch {
              print("Error encoding event data: \(error.localizedDescription)")
              completion(false)
              return
          }
          
          URLSession.shared.dataTask(with: request) { data, response, error in
              if let error = error {
                  print("Error adding new event: \(error.localizedDescription)")
                  completion(false)
                  return
              }

              // Handle the response from the server here
              // ...

              // Call the completion block with success status
              guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                        print("Invalid response from the server")
                        completion(false)
                        return
                    }

              if(httpResponse.statusCode == 201){
                  completion(true)
              }
          }.resume()
      }
}
