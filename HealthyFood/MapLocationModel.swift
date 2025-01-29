//
//  MapLocationModel.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 18/1/2025.
//

import CoreLocation
import MapKit
//Manage User Location
class MapLocationModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    // Update the corresponding map view
    @Published var coordinateRegion: MKCoordinateRegion = MKCoordinateRegion(
        // Initial position
        center: CLLocationCoordinate2D(latitude: 22.2849, longitude: 114.1549),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @Published var currentLocationAnnotation: CurrentLocationAnnotation?
    @Published var authorizationStatus: CLAuthorizationStatus
    
    private var locationManager: CLLocationManager
    private var shouldUpdateRegion: Bool = true

    override init() {
        self.authorizationStatus = .notDetermined
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    // Permission to access the user's location
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    // Set the initial area of ​​the map
    func setupInitialRegion() {
        // Setup initial region
        if let location = locationManager.location {
            coordinateRegion.center = location.coordinate
        }
    }
    // Update location authorization status
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
    // Update the current position when the position changes
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.currentLocationAnnotation = CurrentLocationAnnotation(coordinate: location.coordinate)
        
        if shouldUpdateRegion {
            self.coordinateRegion.center = location.coordinate
        }
    }
    // Set whether to update the map area
    func setShouldUpdateRegion(_ shouldUpdate: Bool) {
        self.shouldUpdateRegion = shouldUpdate
    }
}
