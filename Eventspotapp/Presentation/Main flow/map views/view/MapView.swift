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
        VStack(spacing: 12) {
            if let imageUrl = URL(string: event.image),
               let imageData = try? Data(contentsOf: imageUrl),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .cornerRadius(8)
            }
            Text(event.title)
                .font(.headline)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            Text("Price: \(event.tickets.first?.price.formatted() ?? "0") USD")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button(action: {
                // Handle "Join Event" button action here
            }) {
                Text("Join Event")
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(red: 0.88, green: 0.27, blue: 0.35))
                    .cornerRadius(8)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
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
    @State private var isMapViewLoaded = false // Add this line
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var locationManager = LocationManager() // Add this line
    @ObservedObject var eventVM = EventViewModel()
    @State private var selectedEvent: EventResponse? // Add the selectedEvent variable here

    var body: some View {
        NavigationView{
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
                if isMapViewLoaded {
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
                    .frame(maxWidth: .infinity, maxHeight: 800)
                    .cornerRadius(12)
                 
                    if let selectedEvent = selectedEvent {
                        EventCalloutView(event:selectedEvent)
                        
                            .transition(.slide)
                            .animation(.easeInOut)
                    }
                    
                    
                }}
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

                setInitialRegion()
                fetchEventsLocations()
                }
                isMapViewLoaded = true

            }
            // Add the custom callout view for the selected event
          
         
        }
      
        }


    
    
    private func setInitialRegion() {
        if let userLocation = locationManager.userLocation {
        
                region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
            
        }
    }

    private func fetchEventsLocations() {
        eventVM.fetchEvents { success in
            if success {
                print("Success to fetch events.")
            } else {
                print("Failed to fetch events.")
            }
        }
    }
    
}
