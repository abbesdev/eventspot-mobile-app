//
//  EventView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 14/7/2023.
//

import SwiftUI
import URLImage

struct EventListBox: View {
    var event: EventResponse
      @State private var isExpanded = false
    @State private var isImageLoaded = false

      var body: some View {
          VStack {
              HStack {
                 
                                     URLImage( URL(string: event.image) ?? URL(string: "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930")!,
                                              content: { image in
                                                  image
                                                      .resizable()
                                                      .aspectRatio(contentMode: .fill)
                                                      .frame(width: 60, height: 60)
                                                      .cornerRadius(4)
                                                      .padding(12)
                                     }).frame(width: 60, height: 60)
                      .padding(12)
                                

                               
                   



                           
                  
                  VStack(alignment: .leading) {
                      Text(event.title).font(
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
                          Text("\(event.startDate1, formatter: dateOnlyFormatter)")                    .font(.system(size: 11))
                              .fontWeight(.medium)
                              .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                      }
                      HStack{
                          Image("loc")
                              .resizable()
                              .aspectRatio(contentMode: .fit)
                              .frame(width: 14)
                              .foregroundColor(.blue)
                          
                          Text(String(event.locationLatitude))
                              .font(.system(size: 11))
                              .fontWeight(.medium)
                              .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                      }
                      
                     


                  }
                  Spacer()
                  // Add an arrow icon that changes based on the expansion state
                                 Image(systemName: isExpanded ? "arrow.up" : "arrow.down")
                                     .foregroundColor(.black)
                                     .padding(.horizontal)
              }
             
              .background(Color.white)
              .onTapGesture {
                  withAnimation {
                      isExpanded.toggle()
                  }
              }

              if isExpanded {
                  HStack {
                      Button("Edit Event") {
                          // Perform edit event action
                      } .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                          .background(.white)
                          .cornerRadius(4)
                          .overlay(
                          RoundedRectangle(cornerRadius: 4)
                          .inset(by: 0.75)
                          .stroke(Color(red: 0.13, green: 0.15, blue: 0.17).opacity(0.07), lineWidth: 1.5)
                          )
                          .foregroundColor(.black)
Spacer()
                      Button("Cancel Event") {
                          // Perform cancel event action
                      }
                      .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                      .background(Color(red: 0.88, green: 0.27, blue: 0.35))
                      .cornerRadius(4)
                      .foregroundColor(.white)
                  }
                  .padding()
              }
          }
          .overlay(
          RoundedRectangle(cornerRadius: 4)
          .inset(by: 0.5)
          .stroke(Color(red: 0.67, green: 0.67, blue: 0.67).opacity(0.19), lineWidth: 1)
          )
          
      }
    private let dateOnlyFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
}


struct EventView: View {
    @State private var isAddEventViewShown = false
    @State private var shouldRefreshData = false
    //variables
    @State private var searchText = ""
    @ObservedObject var eventViewModel = EventViewModel()
    @State private var isKeyboardActive = false
    @State private var selectedOption = "Upcoming"
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                NavigationLink(destination: AddEventView().navigationBarBackButtonHidden(true) .onDisappear {
                    refreshEventData()

                }, isActive: $isAddEventViewShown) {
                    EmptyView()
                    
                }
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.14))
                        .frame(maxWidth: .infinity, maxHeight: 48)
                        .padding(.horizontal)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.8))
                            .padding(.leading, 30)
                        
                        TextField("Events, community and more", text: $searchText) { isEditing in
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
                        ForEach(filteredEvents) { event in // Use the filteredEvents array
                            EventListBox(event: event)
                                .listRowInsets(EdgeInsets()) // Remove row insets
                                .padding(.horizontal)
                                .padding(.bottom, 4)
                        }
                    }
                    .listStyle(PlainListStyle()) // Set the list style to PlainListStyle
                }
                else {
                    ScrollView() {
                        ForEach(filteredEvents.filter { event in
                            event.title.localizedCaseInsensitiveContains(searchText)
                        }) { event in
                            EventListBox(event: event)
                                .listRowInsets(EdgeInsets()) // Remove row insets
                                .padding(.horizontal)
                                .padding(.bottom, 4)
                        }
                    }.listStyle(PlainListStyle()) // Set the list style to PlainListStyle
                    
                    
                }
            }
            
            
            .navigationBarTitle("My events", displayMode: .large)
            .onAppear {
                
                    refreshEventData()
                
            }
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("AddEventViewDismissed"))) { _ in
                shouldRefreshData = true
            }
            .navigationBarItems(trailing:
                                    
                                    Button(action: {
                // Perform action when the button is tapped
                isAddEventViewShown = true // Trigger the presentation of AddEventView
                
            }) {
                Text("Add event")
                    .foregroundColor(Color(red: 0.89, green: 0.27, blue: 0.34))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 14)
                
            }
                                
            )
            
            
        }
    }
    private func refreshEventData() {
           eventViewModel.fetchDataEventsByOrganizerID { success in
               // Handle the result of the API call here if needed
           }
       }
        
    
    private var filteredEvents: [EventResponse] {
           let currentDate = Date()
           if selectedOption == "Upcoming" {
               return eventViewModel.eventsByOrganizerId.filter { event in
                   event.startDate1 >= currentDate
               }
           } else {
               return eventViewModel.eventsByOrganizerId.filter { event in
                   event.startDate1 < currentDate
               }
           }
       }
}


struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
