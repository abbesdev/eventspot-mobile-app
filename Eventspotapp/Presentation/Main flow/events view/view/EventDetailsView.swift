//
//  EventDetailsView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 14/7/2023.
//

import SwiftUI
import URLImage
import MapKit

struct EventDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    let event: EventResponse
    @State private var locationName: String = ""

    @State private var isShowingPaymentTicketSheet = false

    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment:.leading){
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
                            // Headline
                            Text("Event Details")
                                .font(
                                    .system( size: 17)
                                    .weight(.bold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .padding(.leading,55)
                            Spacer()
                        }
                    }
                    VStack(alignment:.leading){
                        URLImage( URL(string: event.image) ?? URL(string: "")!) { image in
                            image
                                .resizable()
                                    .cornerRadius(8)
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, maxHeight: 250)
                                    .foregroundColor(.blue)
                                    .padding()
                        }
                        .frame(maxWidth: .infinity, minHeight: 250)
                        HStack{
                            Text(event.title)
                                .font(
                                    .system( size: 20)
                                    .weight(.semibold)
                                )
                                .foregroundColor(.black)
                            Spacer()
                            Text("$\(String(format: "%.2f", event.tickets.first?.price ?? 0.0))")
                                .font(
                                    .system( size: 18)
                                    .weight(.bold)
                                )
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal)
                        HStack{
                            Image("cal")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                                .foregroundColor(.blue)
                            
                            Text("\(event.startDate1, formatter: dateOnlyFormatter)")
                                .font(.system( size: 15))
                            Spacer()
                        }
                        .padding(.horizontal)
                        Divider()
                            .padding()
                        VStack(alignment: .leading){
                            Text("Description")
                                .font(
                                    .system( size: 16)
                                    .weight(.semibold)
                                )
                                .foregroundColor(.black)
                                .padding(.horizontal)
                            
                            Text(event.description)
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                                .foregroundColor(.gray)
                            
                                .padding(.top,2)
                            Divider()
                                .padding()
                            Text("Event organizer")
                                .font(
                                    .system( size: 16)
                                    .weight(.semibold)
                                )
                                .foregroundColor(.black)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity)
                        HStack{
                            Image("tick") // Replace with your image name or URL
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 46, height: 46)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                            VStack{
                                // Label 1
                                Text("Individual")
                                    .font(
                                        .system( size: 17)
                                            .weight(.semibold)
                                    )
                                    .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
                                    .frame(width: 229, alignment: .topLeading)
                                // Subhead
                                Text("Verified organizer")
                                    .font(.system( size: 15))
                                    .foregroundColor(Color(red: 0.61, green: 0.62, blue: 0.64))
                                    .frame(width: 229, alignment: .topLeading)
                            }
                            Spacer()
                            
                        }
                        .padding(.horizontal)
                        Divider()
                            .padding()
                        Text("Location")
                            .font(
                                .system( size: 16)
                                .weight(.semibold)
                            )
                            .foregroundColor(.black)
                            .padding(.horizontal)
                        
                        HStack{
                            Image("loc")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 18, height: 18)
                                .foregroundColor(.blue)
                                .padding(.leading,10)
                            Text(locationName)
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                        }
                        HStack(alignment: .center, spacing: 0) {
                            Text("Set directions in Maps")
                                .foregroundColor(.black)
                        }
                        .onTapGesture {
                               openMapsForDirections()
                           }
                        .frame(maxWidth: .infinity, minHeight: 48, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .background(Color.white)
                        .padding(.horizontal)
                        .padding(.vertical,6)
                    
                 
                        
                    }
                    Divider()
                        .padding()
                    HStack(alignment: .center, spacing: 0) {
                        Text("Join this event")
                            .foregroundColor(.white)
                    }
                    
                    .frame(maxWidth: .infinity, minHeight: 48, alignment: .center)
                    .background(Color(red: 0.88, green: 0.27, blue: 0.35))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .onTapGesture {
                                        // Show the payment ticket sheet when the "Join this event" button is tapped
                                        isShowingPaymentTicketSheet = true
                                    }
           
                }
            }
            .onAppear {
                getLocationNameFromCoordinates(latitude: event.locationLatitude, longitude: event.locationLongitude) { locationName in
                    self.locationName = locationName
                }
            }
            .sheet(isPresented: $isShowingPaymentTicketSheet) {
                        PaymentTicketSheet(event: event)
                    }
        }
    }
    private let dateOnlyFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
    private func getLocationNameFromCoordinates(latitude: Double, longitude: Double, completion: @escaping (String) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil, let placemark = placemarks?.first else {
                completion("Location Not Found")
                return
            }
            
            var nameComponents: [String] = []
            if let name = placemark.name {
                nameComponents.append(name)
            }
            if let city = placemark.locality {
                nameComponents.append(city)
            }
            if let country = placemark.country {
                nameComponents.append(country)
            }
            
            let locationName = nameComponents.joined(separator: ", ")
            completion(locationName)
        }
    }
    private func openMapsForDirections() {
        let latitude = event.locationLatitude
        let longitude = event.locationLongitude
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = event.title // Set the name of the destination in Maps

        // You can specify options for launching the Maps app, if needed
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        
        // Open Maps with the intent for directions
        mapItem.openInMaps(launchOptions: launchOptions)
    }



    
}


