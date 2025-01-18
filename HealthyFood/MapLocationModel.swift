//
//  MapLocationModel.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 18/1/2025.
//
import Foundation
import CoreLocation
import MapKit


class MapLocationModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastLocation: CLLocation?
    @Published var coordinateRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                                                                             span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    @Published var currentLocationAnnotation: CurrentLocationAnnotation?

    private let locationManager: CLLocationManager

    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus

        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            self.authorizationStatus = manager.authorizationStatus
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {
            self.lastLocation = locations.last

            if let lastLocation = self.lastLocation {
                self.coordinateRegion = MKCoordinateRegion(center: lastLocation.coordinate,
                                                           span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
                self.currentLocationAnnotation = CurrentLocationAnnotation(coordinate: lastLocation.coordinate)
            }
        }
    }
}
