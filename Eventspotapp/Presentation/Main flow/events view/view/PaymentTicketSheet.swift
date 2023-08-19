import SwiftUI
import URLImage

struct PaymentTicketSheet: View {
    let event: EventResponse
    @Environment(\.presentationMode) var presentationMode
    @State private var showPaymentForm = false
     @State private var paymentToken: String?
    var body: some View {
        NavigationView {
            VStack {
              
                
                
                // Display the event details in the payment ticket
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
                Divider() // Add another divider
                
                // Add payment and confirmation buttons here
                Button(action: {
                    // Add your payment logic here
                    showPaymentForm = true

                    // For demonstration purposes, just close the sheet when the button is tapped
                }) {
                    Text("Proceed to payment page")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.88, green: 0.27, blue: 0.35))
                        .cornerRadius(12)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .buttonStyle(PlainButtonStyle()) // Remove default button styling
                
                Spacer()
            }
            .sheet(isPresented: $showPaymentForm) {
                
              
                        CheckoutView( event: event)
                           
                    
                  
                
            }

            .navigationBarTitle("Ticket details", displayMode: .large)
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
    // Make an API call to your backend to create the order and process the payment
    // Use URLSession or any other networking library to send the data to the backend


    func createOrder() {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
return
        }
        let paymentToken = "YOUR_PAYMENT_TOKEN" // Replace this with the actual payment token
        let orderData: [String: Any] = [
            "eventId": event.id,
            "ticketType": event.tickets.first?.type,
            "buyer": userId,
            "paymentToken": paymentToken // Pass the payment token to the backend
        ]

        // Use URLSession or any other networking library to send the data to the backend
        guard let url = URL(string: "\(BASE_URL)api/orders") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: orderData)

        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the response from the backend here
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json) // This will be the response from your backend API after processing the payment and creating the order
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}

// Helper view for displaying ticket details in a row format
struct TicketDetailRow: View {
    let title: String
    let value: String
    var formatter: DateFormatter? = nil

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            if let formatter = formatter {
                Text("\(value)")
            } else {
                Text(value)
            }
        }
    }
    
    
}


