//
//  TicketView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 14/7/2023.
//

import SwiftUI
import URLImage

struct TicketListBox: View {
    var order: OrderResponse
    @State var ticketDetailsView: Bool = false

      var body: some View {
          VStack {
              HStack {
                  URLImage(URL(string: order.eventId.image) ?? URL(string: "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930")!,
                                          failure: { error, _ in
                                              // Display the placeholder image in case of an error or if the image is not available
                                              Image("placeholder") // Replace "placeholderImage" with the actual name of your placeholder image asset.
                                                  .resizable()
                                                  .aspectRatio(contentMode: .fill)
                                                  .frame(width: 60, height: 60)
                                                  .cornerRadius(4)
                                                  .padding(12)
                                          },
                                          content: { image in
                                              image
                                                  .resizable()
                                                  .aspectRatio(contentMode: .fill)
                                                  .frame(width: 60, height: 60)
                                                  .cornerRadius(4)
                                                  .padding(12)
                                          })
                           
                  
                  VStack(alignment: .leading) {
                      Text(order.eventId.title).font(
                        .system( size: 14)
                        .weight(.semibold)
                        )
                        .foregroundColor(.black)
                      HStack{
                          Image("cal")
                              .resizable()
                              .aspectRatio(contentMode: .fit)
                              .frame(width: 14)
                              .foregroundColor(.blue)
                          Text("\(order.eventId.startDate1, formatter: dateOnlyFormatter)")                    .font(.system(size: 11))
                              .fontWeight(.medium)
                              .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                      }
                      HStack{
                          Image("loc")
                              .resizable()
                              .aspectRatio(contentMode: .fit)
                              .frame(width: 14)
                              .foregroundColor(.blue)
                          
                          Text(String(order.eventId.locationLatitude))
                              .font(.system(size: 11))
                              .fontWeight(.medium)
                              .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                      }
                      
                     


                  }
                  Spacer()
                  // Add an arrow icon that changes based on the expansion state
                  VStack{
                      Text("$\(order.ticketPrice)")
                          .font(.system(size: 16))
                          .fontWeight(.medium)
                          .foregroundColor(.black)
                          .padding()
                      Spacer()
                  }
              }
              .onTapGesture(perform: {
                  ticketDetailsView = true
              })
             
              .background(Color.white)

          }
          .overlay(
          RoundedRectangle(cornerRadius: 4)
          .inset(by: 0.5)
          .stroke(Color(red: 0.67, green: 0.67, blue: 0.67).opacity(0.19), lineWidth: 1)
          )
          .sheet(isPresented: $ticketDetailsView) {
              TicketDetailsView(event: order)
          }
          
      }
    private let dateOnlyFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
}
struct TicketView: View {
    //variables
    @State private var searchText = ""
    @ObservedObject var orderViewModel = OrderViewModel()
    @State private var isKeyboardActive = false
    @State private var selectedOption = "Upcoming"

    var body: some View {
        
        NavigationView {
            
            VStack {
             
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                        .frame(maxWidth: .infinity, maxHeight: 48)
                        .padding(.horizontal)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.8))
                            .padding(.leading, 30)
                        
                        TextField("Search for tickets", text: $searchText) { isEditing in
                            isKeyboardActive = isEditing
                        }
                        .foregroundColor(.black)
                        .padding(.vertical, 12)
                    }
                    
                }.padding(.top,15)
                   
                Picker(selection: $selectedOption, label: Text("")) {
                    Text("Past").tag("Past")
                    Text("Upcoming").tag("Upcoming")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                if searchText.isEmpty  {
                    ScrollView() {
                        ForEach(filteredOrders) { order in // Use the filteredEvents array
                            TicketListBox(order: order)
                                .listRowInsets(EdgeInsets()) // Remove row insets
                                .padding(.horizontal)
                                .padding(.bottom, 4)
                        }
                    }
                    .listStyle(PlainListStyle()) // Set the list style to PlainListStyle
                }
                else {
                        ScrollView() {
                                ForEach(filteredOrders.filter { order in
                                    order.eventId.title.localizedCaseInsensitiveContains(searchText)
                                }) { order in
                                    TicketListBox(order: order)
                                        .listRowInsets(EdgeInsets()) // Remove row insets
                                        .padding(.horizontal)
                                        .padding(.bottom, 4)
                                }
                            }.listStyle(PlainListStyle()) // Set the list style to PlainListStyle
                            
                        
                    }
                
                }
                .navigationBarTitle("Tickets", displayMode: .large)
                
                                    
                
              
            }
           
           
        }
    
    private var filteredOrders: [OrderResponse] {
           let currentDate = Date()
           if selectedOption == "Upcoming" {
               return orderViewModel.orders.filter { order in
                   order.eventId.startDate1 >= currentDate
               }
           } else {
               return orderViewModel.orders.filter { order in
                   order.eventId.startDate1 < currentDate
               }
           }
       }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView()
    }
}
