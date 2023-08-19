//
//  DashboardView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 14/7/2023.
//

import SwiftUI
import URLImage

//Skeleton loading event box placeholder code
struct GlowingRectangle: View {
    @Binding var isGlowing: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.gray.opacity(isGlowing ? 0.15 : 0.1)) // Adjust opacity here
            .frame(width: 240, height: 170)
            .onAppear {
                startGlowing()
            }
    }
    
    private func startGlowing() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            isGlowing.toggle()
            startGlowing()
        }
    }
}

//Skeleton Loader component
struct SkeletonLoader: View {
    @State private var isGlowing = false

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing: 20) {
                ForEach(0..<3) { _ in
                    GlowingRectangle(isGlowing: $isGlowing)
                }
            }}
        .padding(20)
    }
}

//Explore view
struct DashboardView: View {
    @State private var username = ""
    @State private var searchText = ""
    @ObservedObject var eventViewModel = EventViewModel()
    @State private var isKeyboardActive = false
    @State private var selectedCategory: String? = nil
    @State private var isLoadingEvents = true
    @State private var isMapClicked = false

    
    var body: some View {
        NavigationView {
           
            ScrollView {
                
                VStack(alignment: .leading) {
                    NavigationLink(destination: MapView().navigationBarBackButtonHidden(true), isActive: $isMapClicked) {
                        EmptyView()
                        
                    }
                    HStack(alignment: .center) {
                        Image("logo")
                            .resizable()
                            .frame(width: 120, height: 35)
                        
                        Spacer()
                        Button("Events Map", action: {isMapClicked = true})
                            .foregroundColor(Color(red: 0.88, green: 0.27, blue: 0.35))
                    }
                    .padding(.horizontal)
                    
                    
                    Text("Hello \(username)")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 0.36, green: 0.36, blue: 0.36))
                        .padding(.horizontal)
                        .padding(.top, 12)
                        .padding(.bottom, 1)
                    
                    
                    Text("Discover events Near you")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.25, green: 0.27, blue: 0.32))
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    
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
                    }
                    
                    if searchText.isEmpty  {
                        
                        Section(header: Text("Popular events").padding(.horizontal).padding(.vertical,10).bold()) {
                            Group {
                                if isLoadingEvents {
                                    SkeletonLoader()
                                    
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 20) {
                                            ForEach(eventViewModel.events) { event in
                                                EventBox(event: event)
                                                    .cornerRadius(12)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 12)
                                                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                                    )
                                            }
                                        }
                                        .padding(.horizontal, 10)
                                    }
                                }
                            }
                        }
                        
                        Section(header: Text("Events by category").padding(.horizontal).padding(.top,10).padding(.bottom,10).bold()) {
                            VStack {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(getUniqueCategories(), id: \.self) { category in
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 80)
                                                    .fill(selectedCategory == category ? Color(red: 0.88, green: 0.27, blue: 0.35) : Color.gray.opacity(0.05))
                                                    .frame(height: 35)
                                                Text(category).font(.system(size:18).weight(.medium))
                                                    .foregroundColor(selectedCategory == category ? .white : .black.opacity(0.5))
                                                    .padding(.horizontal)
                                            }
                                            .onTapGesture {
                                                selectedCategory = selectedCategory == category ? nil : category
                                            }
                                        }
                                        .id(UUID())
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.bottom)
                                    
                                }
                                
                                Group {
                                    if isLoadingEvents {
                                        SkeletonLoader()
                                        
                                    } else {
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 20) {
                                                if selectedCategory == nil {
                                                    ForEach(eventViewModel.events) { event in
                                                        EventBox(event: event)
                                                            .cornerRadius(12)
                                                            .overlay(
                                                                RoundedRectangle(cornerRadius: 12)
                                                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                                            )
                                                    }
                                                } else {
                                                    ForEach(eventViewModel.events.filter { event in
                                                        event.category == selectedCategory
                                                    }) { event in
                                                        EventBox(event: event)
                                                            .cornerRadius(12)
                                                            .overlay(
                                                                RoundedRectangle(cornerRadius: 12)
                                                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                                            )
                                                    }
                                                }
                                            }
                                            .padding(.horizontal, 10)
                                        }
                                    }
                                }
                                
                            }
                        }
                    } else {
                        Section(header: Text("Search results").padding().bold()) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(eventViewModel.events.filter { event in
                                        event.title.localizedCaseInsensitiveContains(searchText)
                                    }) { event in
                                        EventBox(event: event)
                                            .cornerRadius(12)
                                        
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                            )
                                    }
                                }.padding(.horizontal, 10)
                                
                            }
                        }
                    }
                    
                    Spacer()
                }
                .onAppear {
                    print("DashboardView onAppear called. Fetching events...")
                    eventViewModel.fetchDataEvents { success in
                        isLoadingEvents = !success
                    }
                }
                
            }
                .onAppear {
           
                if let storedUsername = UserDefaults.standard.string(forKey: "userCredentials") {
                    username = storedUsername
                }
            }
            
           
        }
    }
    // Get unique categories from events
      private func getUniqueCategories() -> [String] {
          let categories = eventViewModel.events.map { $0.category }
          return Array(Set(categories))
      }
}



struct EventBox: View {
    let event: EventResponse
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                URLImage( URL(string: event.image) ?? URL(string: "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930")!) { image in
                                 image
                                     .resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .frame(width: 240, height: 170)
                                     .cornerRadius(8)
                                     .padding(10)
                             }
                             
        
            }
            .frame(width: 240, height: 170)
            .cornerRadius(8)
            .padding(10)
            HStack {
                Text(event.title)
                    .font(.system(size:18))
                    .fontWeight(.semibold)                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                Spacer()
            }
            HStack {
                Image("loc")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
                    .padding(.leading, 10)

                Text(String(event.locationLatitude))
                            .font(.system(size: 11))
                            .fontWeight(.medium)
                            .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                Image("cal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
                    .foregroundColor(.blue)
                    .padding(.leading, 10)
                Text("\(event.startDate1, formatter: dateOnlyFormatter)")                    .font(.system(size: 11))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.trailing, 10)
                Spacer()

            }
            .padding(.bottom, 4)
            HStack {
                Image("p") // Replace with your ticket image URL or asset name from the event object
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120)
                    .padding(.leading, 10)
                Spacer()
                NavigationLink(
                    destination: EventDetailsView(event: event)
                        .navigationBarBackButtonHidden(true)
                    
                ) {
                    HStack(alignment: .center) {
                        Text("View more")
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(Color(red: 0.88, green: 0.27, blue: 0.35))
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(red: 0.88, green: 0.27, blue: 0.35))
                    }
                    .cornerRadius(8)
                    .padding(.trailing, 10)
                }
            }
            .padding(.bottom, 20)
        }
        .onTapGesture {}
    }
}
private let dateOnlyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
private let eventDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM - HH:mm"
    return formatter
}()

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
