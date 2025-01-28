//
//  MapLocationModel.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 18/1/2025.
//

import CoreLocation
import MapKit

class MapLocationModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var coordinateRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 22.2849, longitude: 114.1549), // Initial location
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
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func setupInitialRegion() {
        // Setup initial region
        if let location = locationManager.location {
            coordinateRegion.center = location.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.currentLocationAnnotation = CurrentLocationAnnotation(coordinate: location.coordinate)
        
        if shouldUpdateRegion {
            self.coordinateRegion.center = location.coordinate
        }
    }
    
    func setShouldUpdateRegion(_ shouldUpdate: Bool) {
        self.shouldUpdateRegion = shouldUpdate
    }
}
