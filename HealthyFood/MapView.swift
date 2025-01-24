//
//  MapView.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 18/1/2025.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

class CurrentLocationAnnotation: NSObject, MKAnnotation, Identifiable {
    let id = UUID()
    dynamic var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}

struct MapView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var locationModel = MapLocationModel()
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack(alignment: .leading) {
            if locationModel.authorizationStatus == .authorizedWhenInUse || locationModel.authorizationStatus == .authorizedAlways {
                VStack(alignment: .leading) {
                    Map(coordinateRegion: $locationModel.coordinateRegion, annotationItems: getAnnotations()) { annotation in
                        MapMarker(coordinate: annotation.coordinate, tint: annotation.tintColor)
                    }
                    .frame(height: UIScreen.main.bounds.height * 0.5)
                    .edgesIgnoringSafeArea(.all)
                }
                .padding()
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
        var annotations = restaurants.map { MapAnnotationItem(coordinate: $0.coordinate, tintColor: .white) }
        if let currentLocation = locationModel.currentLocationAnnotation {
            annotations.append(MapAnnotationItem(coordinate: currentLocation.coordinate, tintColor: .red))
        }
        return annotations
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
