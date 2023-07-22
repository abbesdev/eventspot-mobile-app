//
//  MapView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 16/7/2023.
//

import SwiftUI
import MapKit
import CoreLocation

struct EventCalloutView: View {
    let event: EventResponse
    
    var body: some View {
        VStack {
            Text(event.title)
                .font(.headline)
            if let imageUrl = URL(string: event.image),
               let imageData = try? Data(contentsOf: imageUrl),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
            Text("Price: \(event.tickets.first?.price ?? 0) USD")
                .font(.subheadline)
                .foregroundColor(.blue)
        }
        .frame(maxWidth: 300,maxHeight: 200)
        .padding()
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location
    }
}

struct MapView: View {
    @State private var region = MKCoordinateRegion()
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var locationManager = LocationManager() // Add this line
    @ObservedObject var eventVM = EventViewModel()
    @State private var selectedEvent: EventResponse? // Add the selectedEvent variable here

    var body: some View {
        VStack {
            HStack(alignment: .center){
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image("barr") // Replace with your image name or URL
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18) // Adjust the size of the image
                        .foregroundColor(.blue) // Change the color of the image as desired
                        .padding(14)
                        .overlay(
                            Circle()
                            
                                .stroke(Color.gray.opacity(0.4), lineWidth: 0.5)
                        )
                        .padding(.horizontal)
                        .padding(.bottom,8)
                    Text("Nearby events on the map")
                        .foregroundColor(.black)
                        .padding(.bottom,7)
                        .font(.system(size:18,weight: .medium))
                    Spacer()
                }
            }
            .padding(.top,0)
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: eventVM.eventsR) { event in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: event.locationLatitude, longitude: event.locationLongitude)) {
                    Image(systemName: "location.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24) // Adjust the size of the image here
                        .foregroundColor(.red)
                        .onTapGesture {
                                                   // Show the callout view when the user taps on the pin
                                                   selectedEvent = event
                                               }
                }
                
                // Add the custom callout view for the selected event
               
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(12)
            .onAppear {

                setInitialRegion()
                fetchEventsLocations()
            }
            // Add the custom callout view for the selected event
                        if let selectedEvent = selectedEvent {
                            EventDetailsView(event:selectedEvent)
                            
                                .transition(.slide)
                                .animation(.easeInOut)
                        }

            
            
        }
      
        }


    
    
    private func setInitialRegion() {
        if let userLocation = locationManager.userLocation {
            DispatchQueue.main.async {
                region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            }
        }
    }

    private func fetchEventsLocations() {
        eventVM.fetchEvents { success in
            if success {
              
            } else {
                print("Failed to fetch events.")
            }
        }
    }
    
}
