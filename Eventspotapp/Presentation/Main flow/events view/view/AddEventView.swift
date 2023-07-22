import SwiftUI
import Foundation
import MapKit

struct AddEventView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var newTicketType = ""
    @State private var title = ""
    @State private var image = ""
    @State private var description = ""
    @State private var locationLatitude: Double = 0.0
    @State private var locationLongitude: Double = 0.0
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var organizer = ""
    @State private var category = ""
    @State private var newTicketPrice: Double = 0.0
    @State private var newTicketQuantity: Int = 0
    @ObservedObject private var eventViewModel = EventViewModel()
    @State private var isMapViewShown = false
    @State private var selectedCoordinate: CLLocationCoordinate2D?

    var body: some View {
        NavigationView {
          
                VStack
                {
                   
                        TextField("Event Title", text: $title)
                            .frame(maxWidth: .infinity, maxHeight: 48)
                            .padding(.horizontal)
                            .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                            .cornerRadius(4)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                            .padding(.top,20)
                        
                        TextField("Event Image URL", text: $image)
                            .frame(maxWidth: .infinity, maxHeight: 48)
                            .padding(.horizontal)
                            .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                            .cornerRadius(4)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                        
                        TextField("Event Description", text: $description)
                            .frame(maxWidth: .infinity, maxHeight: 48)
                            .padding(.horizontal)
                            .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                            .cornerRadius(4)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                        
                    Button(action: {
                        isMapViewShown = true
                    }) {
                        if let selectedCoordinate = selectedCoordinate {
                            Text("Latitude: \(selectedCoordinate.latitude), Longitude: \(selectedCoordinate.longitude)")
                                .frame(maxWidth: .infinity, maxHeight: 48)
                                .padding(.horizontal)
                                .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                                .cornerRadius(4)
                                .padding(.horizontal)
                                .padding(.bottom, 10)
                        } else {
                            Text("Choose Location")
                                .frame(maxWidth: .infinity, maxHeight: 48)
                                .padding(.horizontal)
                                .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                                .cornerRadius(4)
                                .padding(.horizontal)
                                .padding(.bottom, 10)
                        }
                    }
                    .sheet(isPresented: $isMapViewShown, onDismiss: {
                        // Save the selected coordinates to the locationLongitude and locationLatitude variables
                        if let selectedCoordinate = selectedCoordinate {
                            locationLongitude = selectedCoordinate.longitude
                            locationLatitude = selectedCoordinate.latitude
                        }
                    }) {
                        // Show the map view when the button is tapped
                        MapViewChoose(selectedCoordinate: $selectedCoordinate)
                    }
                        
                    DatePicker("Start Date", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                        .frame(maxWidth: .infinity, maxHeight: 48)
                        .padding(.horizontal)
                        .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                        .cornerRadius(4)
                        .padding(.horizontal)
                        .padding(.bottom, 10)

                    DatePicker("End Date", selection: $endDate, displayedComponents: [.date, .hourAndMinute])
                        .frame(maxWidth: .infinity, maxHeight: 48)
                        .padding(.horizontal)
                        .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                        .cornerRadius(4)
                        .padding(.horizontal)
                        .padding(.bottom, 10)

                        
                        TextField("Organizer", text: $organizer)
                            .frame(maxWidth: .infinity, maxHeight: 48)
                            .padding(.horizontal)
                            .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                            .cornerRadius(4)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                        
                        TextField("Category", text: $category)
                            .frame(maxWidth: .infinity, maxHeight: 48)
                            .padding(.horizontal)
                            .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                            .cornerRadius(4)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                    
                    
               
                        
                       
                    Spacer()
                }
            
            
            .navigationBarTitle("New Event", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Create") {
                    let newEvent = EventCreateModel(
                        title: title, image: image, description: description, locationLatitude: 33,locationLongitude: 16, startDate: startDate, endDate: endDate, organizer: "64b688f112e1ecffd82858ae", category: category, tickets: []
                    )
                    eventViewModel.addNewEvent(event: newEvent) { success in
                        // Handle the result of the API call here
                        if success {
                            print("Event added successfully!")
                            
                        } else {
                            print("Failed to add event.")
                        }
                        
//                         Dismiss the AddEventView after the event is added
//                                            Add animation of tick success here to do 22July 2023
//
//
//
//
//
                    }

                }
            )
        }
    }

}




struct TicketCreateModel: Codable {
    var type: String
    var price: Double
    var quantity: Int
}

struct EventCreateModel: Codable {
    var title: String
    var image: String
    var description: String
    var locationLatitude: Double
    var locationLongitude: Double
    var startDate: Date
    var endDate: Date
    var organizer: String
    var category: String
    var tickets: [TicketCreateModel]
    
    enum CodingKeys: String, CodingKey {
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
       }
}

struct MapViewChoose: View {
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    @State private var annotations: [MKPointAnnotation] = []
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.022309, longitude: 10.515809), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $mapRegion,
                    annotationItems: annotations) { annotation in
                    MapPin(coordinate: annotation.coordinate)
                }
                .onTapGesture {
                    // Check if the selectedCoordinate is not nil to remove previous selection
                    if selectedCoordinate != nil {
                        annotations.removeAll()
                    }
                    // Convert the tap location to a coordinate
                    let location = tapLocationToCoordinate($0)
                    
                    // Update the annotations array to show the pin at the selected coordinate
                    let newAnnotation = MKPointAnnotation()
                    newAnnotation.coordinate = location
                    annotations.append(newAnnotation)
                    
                    // Set the selected coordinate
                    selectedCoordinate = location
                    showAlert = true
                    // Update the map region only when a location is not selected yet
                    if selectedCoordinate == nil {
                        mapRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                    }
                }
                
               
            }
            .navigationBarTitle("Choose Location", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        // Dismiss the map view when the "Done" button is tapped
                        selectedCoordinate = nil
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Selected Coordinates"),
                      message: Text("Latitude: \(selectedCoordinate?.latitude ?? 0.0)\nLongitude: \(selectedCoordinate?.longitude ?? 0.0)"),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func tapLocationToCoordinate(_ tap: CGPoint) -> CLLocationCoordinate2D {
        let coordinate = MKMapView().convert(tap, toCoordinateFrom: nil)
        return coordinate
    }
}
