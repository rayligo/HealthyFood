//
//  MapView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 18/1/2025.
//

import SwiftUI
import MapKit
import CoreLocation

// The class of the current location
class CurrentLocationAnnotation: NSObject, MKAnnotation, Identifiable {
    let id = UUID()
    dynamic var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}

// Display the map view
    struct MapView: View {
        @Environment(\.managedObjectContext) private var viewContext
        @StateObject var locationModel = MapLocationModel()
        
        @State private var initialSetupDone = false
        
        var body: some View {
            VStack(alignment: .leading) {
                if locationModel.authorizationStatus == .authorizedWhenInUse || locationModel.authorizationStatus == .authorizedAlways {
                    VStack(alignment: .leading) {
                        Map(coordinateRegion: $locationModel.coordinateRegion, annotationItems: getAnnotations()) { annotation in
                            MapAnnotation(coordinate: annotation.coordinate) {
                                Circle()
                                    .fill(annotation.tintColor)
                                    .frame(width: 10, height: 10)
                            }
                        }
                        .frame(height: UIScreen.main.bounds.height * 0.5)
                        .edgesIgnoringSafeArea(.all)
                    }
                    .padding()
                    .onAppear {
                        if !initialSetupDone {
                            locationModel.setupInitialRegion()
                            initialSetupDone = true
                        }
                    }
                } else {
                    VStack {
                        Button("Request Permission", action: {
                            locationModel.requestPermission()
                        })
                    }
                    .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        
        private func getAnnotations() -> [MapAnnotationItem] {
            var annotations = restaurants.map { MapAnnotationItem(coordinate: $0.coordinate, tintColor: .blue, restaurant: $0) }
            if let currentLocation = locationModel.currentLocationAnnotation {
                annotations.append(MapAnnotationItem(coordinate: currentLocation.coordinate, tintColor: .red, restaurant: HealthyRestaurants(name: "Current Location", coordinate: currentLocation.coordinate)))
            }
            return annotations
        }
    }

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
