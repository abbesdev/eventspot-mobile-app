//
//  PaymentFormView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 29/7/2023.
//

import SwiftUI
import Stripe
import URLImage

import StripePaymentSheet

class MyBackendModel: ObservableObject {
  let backendCheckoutUrl = URL(string: "\(BASE_URL)api/orders")! // Your backend endpoint
  @Published var paymentSheet: PaymentSheet?
  @Published var paymentResult: PaymentSheetResult?

    func preparePaymentSheet(amount:Int) {
      let amountInCents = amount // Replace with the desired payment amount in cents

         let requestBody: [String: Any] = [
             "amount": amountInCents
         ]

         // Convert the request body to JSON data
         guard let requestBodyData = try? JSONSerialization.data(withJSONObject: requestBody) else {
             return // Handle error
         }

         // Create a URL request
         var request = URLRequest(url: backendCheckoutUrl)
         request.httpMethod = "POST"
         request.httpBody = requestBodyData
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")


    let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
        if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("JSON Response: \(json)")
                }
            }

            if let error = error {
                print("Error: \(error)")
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }

            print("HTTP Response: \(httpResponse)")
      guard let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
            let customerId = json["customer"] as? String,
            let customerEphemeralKeySecret = json["ephemeralKey"] as? String,
            let paymentIntentClientSecret = json["paymentIntent"] as? String,
            let publishableKey = json["publishableKey"] as? String,
            let self = self
            
        else {
        // Handle error
          return
          

      }

      STPAPIClient.shared.publishableKey = publishableKey
      // MARK: Create a PaymentSheet instance
      var configuration = PaymentSheet.Configuration()
      configuration.merchantDisplayName = "Example, Inc."
      configuration.customer = .init(id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
      // Set `allowsDelayedPaymentMethods` to true if your business can handle payment methods
      // that complete payment after a delay, like SEPA Debit and Sofort.
      configuration.allowsDelayedPaymentMethods = true
        print("this step is reached 2 dispatch queue")

      DispatchQueue.main.async {
          print("this step is reached 3 dispatch queue")
        self.paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentIntentClientSecret, configuration: configuration)
          print(self.paymentSheet)
      }
    })
    task.resume()
  }

  func onPaymentCompletion(result: PaymentSheetResult) {
    self.paymentResult = result
  }
}

struct CheckoutView: View {
  @ObservedObject var model = MyBackendModel()
    let event: EventResponse
    @Environment(\.presentationMode) var presentationMode

  var body: some View {
      NavigationView{
          VStack {
              
              if let paymentSheet = model.paymentSheet {
                  VStack(alignment: .leading, spacing: 10) {
                      HStack{
                          URLImage(URL(string: event.image) ?? URL(string: "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930")!,
                                   failure: { error, _ in
                              // Display the placeholder image in case of an error or if the image is not available
                              Image("placeholder") // Replace "placeholderImage" with the actual name of your placeholder image asset.
                                  .resizable()
                                  .aspectRatio(contentMode: .fill)
                                  .frame(width: 100, height: 100)
                                  .cornerRadius(4)
                                  .padding(4)
                          },
                                   content: { image in
                              image
                                  .resizable()
                                  .aspectRatio(contentMode: .fill)
                                  .frame(width: 100, height: 100)
                                  .cornerRadius(4)
                                  .padding(4)
                          }).frame(width: 100, height: 100)
                              .cornerRadius(4)
                              .padding(4)
                          VStack{
                              Text(event.title)
                                  .font(
                                    .system( size: 16)
                                    .weight(.bold)
                                  )
                                  .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.09))
                                  .frame(maxWidth: .infinity, alignment: .leading)
                                  .padding(.bottom,10)
                              Text("\(event.locationLatitude)")
                                  .font(.system( size: 12))
                                  .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                                  .frame(maxWidth: .infinity, alignment: .leading)
                          }.padding()
                      }
                      VStack(alignment: .center, spacing: 4) { Text("Non-refundable")
                              .font(
                                .system( size: 12)
                                .weight(.bold)
                              )
                              .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.09))
                              .frame(maxWidth: .infinity, alignment: .leading)
                          Text("You can not refund your payment when you cancel payment")
                              .font(
                                .system( size: 10)
                                .weight(.medium)
                              )
                              .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.09))
                              .frame(maxWidth: .infinity, alignment: .leading)
                      }
                      .padding(14)
                      .frame(maxWidth: .infinity, alignment: .center)
                      .background(Color(red: 0.09, green: 0.09, blue: 0.09).opacity(0.02))
                      .cornerRadius(14)
                      .shadow(color: .black.opacity(0.02), radius: 4, x: 0, y: 1)
                      .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.09, green: 0.09, blue: 0.09).opacity(0.04), lineWidth: 1)
                      )
                      HStack(alignment: .center, spacing: 14) {
                          HStack(alignment: .center, spacing: 0) { Text(event.startDate1,formatter:dateOnlyFormatter)
                                  .font(
                                    .system( size: 12)
                                    .weight(.medium)
                                  )
                                  .multilineTextAlignment(.center)
                                  .foregroundColor(Color(red: 0.88, green: 0.27, blue: 0.35))
                                  .frame(maxWidth: .infinity, alignment: .center)
                              
                          }
                          .padding(.horizontal, 10)
                          .padding(.vertical, 4)
                          .frame(maxWidth: .infinity, minHeight: 42, maxHeight: 42, alignment: .center)
                          .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.88, green: 0.27, blue: 0.35).opacity(0.06), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.88, green: 0.27, blue: 0.35).opacity(0.06), location: 0.76),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                          )
                          .cornerRadius(8)
                          HStack(alignment: .center, spacing: 0) { Text(event.startDate1,formatter:timeOnlyFormatter)
                                  .font(
                                    .system( size: 12)
                                    .weight(.medium)
                                  )
                                  .multilineTextAlignment(.center)
                                  .foregroundColor(Color(red: 0.88, green: 0.27, blue: 0.35))
                              .frame(maxWidth: .infinity, alignment: .center) }
                          .padding(.horizontal, 10)
                          .padding(.vertical, 4)
                          .frame(maxWidth: .infinity, minHeight: 42, maxHeight: 42, alignment: .center)
                          .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.88, green: 0.27, blue: 0.35).opacity(0.06), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.88, green: 0.27, blue: 0.35).opacity(0.06), location: 0.76),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                          )
                          .cornerRadius(8)
                      }
                      .padding(.horizontal, 0)
                      .padding(.vertical, 14)
                      .frame(maxWidth: .infinity, alignment: .center)
                      .background(.white)
                      .cornerRadius(14)
                      .shadow(color: .black.opacity(0.02), radius: 4, x: 0, y: 1)
                      VStack(alignment: .center, spacing: 18) {
                          Text("Payment Summary")
                              .font(
                                .system( size: 14)
                                .weight(.semibold)
                              )
                              .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.09))
                              .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                          
                          HStack(alignment: .center, spacing: 0) { Text("Subtotal")
                                  .font(
                                    .system( size: 12)
                                    .weight(.medium)
                                  )
                                  .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.09))
                                  .frame(maxWidth: .infinity, alignment: .leading)
                              Text("\(event.tickets.first?.price ?? 0.0) ")
                                  .font(
                                    .system( size: 12)
                                    .weight(.medium)
                                  )
                                  .multilineTextAlignment(.trailing)
                                  .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.09).opacity(0.52))
                          }
                          .padding(0)
                          .frame(width: 310, alignment: .center)
                          HStack(alignment: .center, spacing: 0) {Text("Ticket type")
                                  .font(
                                    .system( size: 12)
                                    .weight(.medium)
                                  )
                                  .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.09))
                                  .frame(maxWidth: .infinity, alignment: .leading)
                              Text("\(event.tickets.first?.type ?? "")")
                                  .font(
                                    .system( size: 12)
                                    .weight(.medium)
                                  )
                                  .multilineTextAlignment(.trailing)
                                  .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.09).opacity(0.52))
                          }
                          .padding(0)
                          .frame(width: 310, alignment: .center)
                          
                          Rectangle()
                              .foregroundColor(.clear)
                              .frame(width: 310, height: 1)
                              .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                          HStack(alignment: .center, spacing: 0) { Text("Total Payment")
                                  .font(
                                    .system(size: 12)
                                    .weight(.semibold)
                                  )
                                  .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.09))
                                  .frame(maxWidth: .infinity, alignment: .leading)
                              
                              Text("\(event.tickets.first?.price ?? 0.0)")
                                  .font(
                                    .system( size: 12)
                                    .weight(.semibold)
                                  )
                                  .multilineTextAlignment(.trailing)
                                  .foregroundColor(Color(red: 0.88, green: 0.27, blue: 0.35))
                              
                          }
                          .padding(0)
                          .frame(width: 310, alignment: .center)
                      }
                      .padding(14)
                      .frame(maxWidth: .infinity, alignment: .center)
                      .background(.white)
                      .cornerRadius(14)
                      .shadow(color: .black.opacity(0.02), radius: 4, x: 0, y: 1)
                  }
                  .padding()
                  Spacer()
                  PaymentSheet.PaymentButton(
                    paymentSheet: paymentSheet,
                    onCompletion: model.onPaymentCompletion
                  ) {
                      
                      
                      Text("Pay now")
                          .foregroundColor(.white)
                          .font(.headline)
                          .padding(.vertical, 12)
                      
                          .frame(maxWidth: .infinity)
                          .background(Color(red: 0.88, green: 0.27, blue: 0.35))
                          .cornerRadius(12)
                      
                  }.padding(.horizontal, 16)
              } else {
                  Text("Loading…")
              }
              if let result = model.paymentResult {
                  
                  switch result {
                  case .completed:
                      Text("Payment complete")
                          .onAppear {
                              createOrderInDatabase(event:event)

                                         presentationMode.wrappedValue.dismiss()
                                     }
                      
                  case .failed(let error):
                      Text("Payment failed: \(error.localizedDescription)")
                  case .canceled:
                      Text("Payment canceled.")
                  }
              }
              
          }.onAppear { model.preparePaymentSheet(amount: Int(event.tickets.first!.price*100)) }
              .navigationBarTitle("Payment Details", displayMode: .large)
              .navigationBarItems(leading:
                                    
                                    Button(action: {
                  // Perform action when the button is tapped
                  presentationMode.wrappedValue.dismiss()
                  
              }) {
                  Text("Cancel")
                      .foregroundColor(Color(red: 0.89, green: 0.27, blue: 0.34))
                      .padding(.vertical, 6)
                      .padding(.horizontal, 6)
                  
              }
                                  
              )
      }
  }
    func createOrderInDatabase(event:EventResponse) {
        // Create a URLRequest for your backend order creation endpoint
        let orderUrl = URL(string: "\(BASE_URL)api/orderdb")! // Update the URL as needed
        var request = URLRequest(url: orderUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")


        // Create and set the request body
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
return
        }
        let orderData: [String: Any] = [
            "ticketPrice": event.tickets.first?.price ?? 0.0, // Use a default value, e.g., 0.0, if price is nil
            "eventId": event.id,
            "ticketType": event.tickets.first?.type ?? "", // Use an empty string if type is nil
            "buyer": userId
        ]

        print(orderData)
        request.httpBody = try? JSONSerialization.data(withJSONObject: orderData)

        // Perform the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print(data)
            // Handle the response here
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Order creation response: \(json)")
                }
            }
            if let error = error {
                print("Error creating order: \(error)")
            }
        }
        task.resume()
    }
    private let dateOnlyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    private let timeOnlyFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a" // Use the format you want, e.g., "h:mm a" for 12-hour time format with AM/PM
            return formatter
        }()
}
