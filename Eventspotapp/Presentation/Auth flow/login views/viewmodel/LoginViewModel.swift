import SwiftUI
import Combine

struct UserCredentials: Codable {
    let email: String
    let password: String
}

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoggedIn = false

    private var cancellable: AnyCancellable?

    func login() {
        let loginURL = URL(string: "http://localhost:3000/api/login")! // Replace with your login API URL

        let credentials = UserCredentials(email: email, password: password)

        guard let encodedData = try? JSONEncoder().encode(credentials) else {
            print("Failed to encode login credentials")
            return
        }

        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.httpBody = encodedData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: UserResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Login failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] userResponse in
                // Handle the successful login response here
                // Save the token and user credentials in UserDefaults
                UserDefaults.standard.set(userResponse.token, forKey: "userToken")
                UserDefaults.standard.set(userResponse.user.username, forKey: "userCredentials")
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                self?.isLoggedIn = true
                print("\(userResponse.user)")
                
            })
    }
}
