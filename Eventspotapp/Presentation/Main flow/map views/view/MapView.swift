//
//  MapView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 16/7/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion()
    @Environment(\.presentationMode) var presentationMode

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
            .padding(.top,20)
            Map(coordinateRegion: $region)
                .frame(maxWidth:.infinity, maxHeight: .infinity)
                .cornerRadius(12)
                .onAppear {
                    setRegion()
                }
                .padding()
            
            
        }
        }


    
    
    private func setRegion() {
        let location = CLLocation(latitude: 5456.5145, longitude: 11.24045)
          region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
      }
    
}
