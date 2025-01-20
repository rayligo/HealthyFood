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
    @State var coordinateRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                                                                          span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    
    var body: some View {
        VStack {
                    if locationModel.authorizationStatus == .authorizedWhenInUse || locationModel.authorizationStatus == .authorizedAlways {

                        Text("Lat: \(locationModel.lastLocation?.coordinate.latitude ?? 0)")
                        Text("Lng: \(locationModel.lastLocation?.coordinate.longitude ?? 0)")

                        Map(coordinateRegion: $locationModel.coordinateRegion, annotationItems: getAnnotations()) { annotation in
                            MapMarker(coordinate: annotation.coordinate, tint: annotation.tintColor)
                        }
                    } else {
                        Button("Request Permission", action: {
                            locationModel.requestPermission()
                        })
                    }
                }
                .padding()

                Spacer()
                    
                Divider()
                    .padding([.leading, .trailing], 20)
                    .frame(height: 2)
                    .background(Color.gray)
                
                HStack(spacing: 10) {
                    ForEach(1..<5) { index in
                        if index == 2 {
                            Image("map")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.width / 5 - 20, height: UIScreen.main.bounds.width / 5 - 20)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .foregroundColor(.white)
                        } else if index == 1 {
                            NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true)) {
                                Image("notebook")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width / 5 - 20, height: UIScreen.main.bounds.width / 5 - 20)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                            }
                        } else {
                            NavigationLink(destination: NoteBookView().environment(\.managedObjectContext, viewContext)) {
                                Image("notebook")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width / 5 - 20, height: UIScreen.main.bounds.width / 5 - 20)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .padding(.bottom, 10)
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
