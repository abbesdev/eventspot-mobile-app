//
//  DashboardViewModel.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 22/7/2023.
//

import Foundation
import Combine


class OrderViewModel: ObservableObject {
    @Published var orders = [OrderResponse]()

    private var cancellable: AnyCancellable?

    init() {
   
        fetchDataOrdersByBuyerID { _ in }
    }

   
    func fetchDataOrdersByBuyerID(completion: @escaping (Bool) -> Void) {
        

        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
return
        }

           let urlString = "\(BASE_URL)api/orders/\(userId)"

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
                let decodedData = try JSONDecoder().decode([OrderResponse].self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.orders = decodedData
                    completion(true)
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(false)
            }
        }.resume()
      
       
    }
    
}
