import SwiftUI
import Foundation
import MapKit
import Combine


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
@State private var newTicketPrice: String = "0.0"
@State private var newTicketQuantity: String = ""
@ObservedObject private var eventViewModel = EventViewModel()
@State private var isMapViewShown = false
@State private var selectedCoordinate: CLLocationCoordinate2D?

var body: some View {
    NavigationView {
        ScrollView{
        VStack
        {
            
            TextField("Event Title", text: $title)
                .frame(maxWidth: .infinity, minHeight: 48)
                .padding(.horizontal)
                .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                .cornerRadius(4)
                .padding(.horizontal)
                .padding(.bottom, 10)
                .padding(.top,20)
            
            TextField("Event Image URL", text: $image)
                .frame(maxWidth: .infinity, minHeight: 48)
                .padding(.horizontal)
                .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                .cornerRadius(4)
                .padding(.horizontal)
                .padding(.bottom, 10)
            
            TextField("Event Description", text: $description)
                .frame(maxWidth: .infinity, minHeight: 48)
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
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .padding(.horizontal)
                        .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                        .cornerRadius(4)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                } else {
                    Text("Choose Location")
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .padding(.horizontal)
                        .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                        .cornerRadius(4)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                }
            }
            
            
            DatePicker("Start Date", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                .frame(maxWidth: .infinity, minHeight: 48)
                .padding(.horizontal)
                .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                .cornerRadius(4)
                .padding(.horizontal)
                .padding(.bottom, 10)
            
            DatePicker("End Date", selection: $endDate, displayedComponents: [.date, .hourAndMinute])
                .frame(maxWidth: .infinity, minHeight: 48)
                .padding(.horizontal)
                .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                .cornerRadius(4)
                .padding(.horizontal)
                .padding(.bottom, 10)
            
            
            TextField("Ticket Quantity", text: $newTicketQuantity)
                .frame(maxWidth: .infinity, minHeight: 48)
                .padding(.horizontal)
                .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                .cornerRadius(4)
                .padding(.horizontal)
                .padding(.bottom, 10)
            TextField("Ticket Price", text: $newTicketPrice)
                .frame(maxWidth: .infinity, minHeight: 48)
                .padding(.horizontal)
                .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                .cornerRadius(4)
                .padding(.horizontal)
                .padding(.bottom, 10)
            TextField("Category", text: $category)
                .frame(maxWidth: .infinity, minHeight: 48)
                .padding(.horizontal)
                .background(Color(red: 0.79, green: 0.8, blue: 0.82).opacity(0.24))
                .cornerRadius(4)
                .padding(.horizontal)
                .padding(.bottom, 10)
            
            
            
            
            
            Spacer()
        }}
        
            .sheet(isPresented: $isMapViewShown) {
                            MapViewSheet(selectedCoordinate: $selectedCoordinate)
                               
                        }
        .navigationBarTitle("New Event", displayMode: .inline)
        .background(Color.white) // Set the background color for the navigation bar

        .navigationBarItems(
            leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            },
            trailing: Button("Create") {
                if let organizerID = UserDefaults.standard.string(forKey: "userId") {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

                    let formattedStartDate = dateFormatter.string(from: startDate)
                    let formattedEndDate = dateFormatter.string(from: endDate)
                    let newEvent = EventCreateModel(
                        title: title, image: image, description: description, locationLatitude: selectedCoordinate!.latitude,locationLongitude: selectedCoordinate!.longitude, startDate: formattedStartDate, endDate: formattedEndDate, organizer: organizerID, category: category, tickets: [TicketCreateModel(type: "Standard", price: Double(newTicketPrice)!, quantity: Int(newTicketQuantity)!)]
                    )
                    eventViewModel.addNewEvent(event: newEvent) { success in
                        // Handle the result of the API call here
                        if success {
                            print("Event added successfully!")

                        } else {
                            print("Failed to add event.")
                        }

                    }
                    
                }else {
                    
                }
                presentationMode.wrappedValue.dismiss()
            }
        )
    }
}

}
struct MapViewSheet: View {
@Binding var selectedCoordinate: CLLocationCoordinate2D?
@State private var searchQuery = ""
@State private var searchResults: [MKMapItem] = []

var body: some View {
    NavigationView {
        VStack {
            SearchBar(text: $searchQuery, onSearch: searchForLocation)

            List(searchResults, id: \.self) { item in
                Button(action: {
                    selectedCoordinate = item.placemark.coordinate
                }) {
                    Text(item.placemark.title ?? "")
                }
            }
        }
        .navigationBarTitle("Search Locations")
    }
}

private func searchForLocation() {
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = searchQuery
    
    let search = MKLocalSearch(request: request)
    search.start { response, _ in
        if let mapItems = response?.mapItems {
            searchResults = mapItems
        } else {
            searchResults = []
        }
    }
}
}


struct SearchBar: UIViewRepresentable {
@Binding var text: String
var onSearch: () -> Void

class Coordinator: NSObject, UISearchBarDelegate {
    var parent: SearchBar

    init(_ parent: SearchBar) {
        self.parent = parent
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        parent.text = searchText
        parent.onSearch()
    }
}

func makeCoordinator() -> Coordinator {
    Coordinator(self)
}

func makeUIView(context: Context) -> UISearchBar {
    let searchBar = UISearchBar()
    searchBar.delegate = context.coordinator
    return searchBar
}

func updateUIView(_ uiView: UISearchBar, context: Context) {
    uiView.text = text
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
var startDate: String
var endDate: String
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


