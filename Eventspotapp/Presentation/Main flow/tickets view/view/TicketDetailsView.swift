//
//  TicketDetailsView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 21/7/2023.
//

import SwiftUI
import URLImage

struct TicketDetailsView: View {
    let event: OrderResponse
    @Environment(\.presentationMode) var presentationMode
    @State private var username = ""

    var body: some View {
        NavigationView {
            VStack {
              
                
                
                // Display the event details in the payment ticket
                VStack(alignment: .leading, spacing: 10) {
                    HStack{
                        URLImage(URL(string: event.eventId.image) ?? URL(string: "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930")!,
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
                                                })
                        VStack{
                            Text(event.eventId.title)
                              .font(
                                .system( size: 16)
                                  .weight(.bold)
                              )
                              .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.09))
                              .frame(maxWidth: .infinity, alignment: .leading)
                              .padding(.bottom,10)
                            Text("\(event.eventId.locationLatitude)")
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
                        HStack(alignment: .center, spacing: 0) { Text(event.eventId.startDate1,formatter:dateOnlyFormatter)
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
                        HStack(alignment: .center, spacing: 0) { Text(event.eventId.startDate1,formatter:timeOnlyFormatter)
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
                            Text("\(event.ticketPrice)")
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
                            Text("\(event.ticketType)")
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
                            
                            Text("\(event.ticketPrice)")
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
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 325.06403, height: 0.5)
                      .background(Color(red: 0.88, green: 0.88, blue: 0.88))
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(alignment: .top) {
                        // Space Between
                            VStack(alignment: .leading, spacing: 0) {// Text S/Regular
                                Text("Person name")
                                  .font(.system( size: 12))
                                  .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                                
                                // Text L/Medium
                                Text("\(username)")
                                  .font(
                                    .system( size: 16)
                                      .weight(.medium)
                                  )
                                  .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25))
                            }
                            .padding(0)
                        Spacer()
                        // Alternative Views and Spacers
                            VStack(alignment: .trailing, spacing: 0) {
                                
                                // Text S/Regular
                                Text("Ticket Number")
                                  .font(.system( size: 12))
                                  .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                                
                                
                                // Text L/Medium
                                Text(event.id)
                                  .font(
                                    .system( size: 16)
                                      .weight(.medium)
                                  )
                                  .foregroundColor(Color(red: 0.25, green: 0.25, blue: 0.25))
                            }
                            .padding(0)
                            
                      }
                      .padding(0)
                      .frame(maxWidth: .infinity, alignment: .top)
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 325.06403, height: 0.5)
                          .background(Color(red: 0.88, green: 0.88, blue: 0.88))
                        
                        Image("barcode")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity,maxHeight:300)
                    }
                    .padding(20)
                    .frame(width: 365.06403, alignment: .leading)
                    .background(.white)
                    .cornerRadius(20)
                    
                }
                .padding()
               
                
         
            }
            .navigationBarTitle("Ticket details", displayMode: .inline)
            .navigationBarItems(leading:
                                    
                                    Button(action: {
                // Perform action when the button is tapped
                presentationMode.wrappedValue.dismiss()

            }) {
                Text("Return")
                    .foregroundColor(Color(red: 0.89, green: 0.27, blue: 0.34))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 6)
                
            }
                                
            )
            .onAppear {
                if let storedUsername = UserDefaults.standard.string(forKey: "userCredentials") {
                    username = storedUsername
                }
            }
            // Close the payment ticket sheet when tapped outside
            Spacer()
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
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
}

