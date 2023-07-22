//
//  EventDetailsView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 14/7/2023.
//

import SwiftUI
import MapKit
import URLImage

struct EventDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    let event: EventResponse
    @State private var region = MKCoordinateRegion()
    @State private var isLocationGeocoded = false
    @State private var annotations: [MKPointAnnotation] = []
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
                            Image(systemName: "calendar")
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
                            Image("avatar") // Replace with your image name or URL
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 46, height: 46)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                            VStack{
                                // Label 1
                                Text(event.organizer)
                                    .font(
                                        .system( size: 17)
                                            .weight(.semibold)
                                    )
                                    .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
                                    .frame(width: 229, alignment: .topLeading)
                                // Subhead
                                Text("CEO of SpaceX")
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
                            Image(systemName: "location.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 11, height: 11)
                                .foregroundColor(.blue)
                                .padding(.leading,10)
                            Text("\(event.locationLatitude)")
                                .font(.system( size: 12))
                                .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                        }
                        if isLocationGeocoded {
                            Map(coordinateRegion: $region, annotationItems: annotations) { annotation in
                                                       MapPin(coordinate: annotation.coordinate)
                                                   }
                                                   .frame(height: 300)
                                                   .cornerRadius(12)
                                                   .padding()
                                           } else {
                                               ProgressView("Wait for the map to load please...")
                                                   .padding()
                                                   .onAppear {
                                                       setRegion()
                                                   }
                                           }
                 
                        
                    }
                    Divider()
                        .padding()
                    HStack(alignment: .center, spacing: 0) {
                        Text("Join this event")
                            .foregroundColor(.white)
                    }
                    
                    .frame(maxWidth: .infinity, minHeight: 48, alignment: .center)
                    .background(Color(red: 0.88, green: 0.27, blue: 0.35))
                    .cornerRadius(4)
                    .padding(.horizontal)
                    .onTapGesture {
                                        // Show the payment ticket sheet when the "Join this event" button is tapped
                                        isShowingPaymentTicketSheet = true
                                    }
           
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
    private func setRegion() {
        let location = CLLocation(latitude: event.locationLatitude, longitude: event.locationLongitude)
        
        // Use CLGeocoder to perform reverse geocoding
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Error geocoding location: \(error.localizedDescription)")
                return
            }
            
            // Update the region once reverse geocoding is complete
            if let placemark = placemarks?.first {
                let coordinateRegion = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                region = coordinateRegion
                isLocationGeocoded = true // Set the flag to true once the geocoding is done
                annotations = [MKPointAnnotation(__coordinate: location.coordinate)] // Add a map annotation for the event location
            }
        }
    }
    
}
extension MKPointAnnotation: Identifiable {
    public var id: UUID { UUID() }
}

