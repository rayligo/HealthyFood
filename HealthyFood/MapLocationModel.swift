//
//  MapLocationModel.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 18/1/2025.
//

import Combine
import CoreLocation
import MapKit

class MapLocationModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastLocation: CLLocation?
    @Published var coordinateRegion: MKCoordinateRegion
    @Published var currentLocationAnnotation: CurrentLocationAnnotation?

    private let locationManager: CLLocationManager
    private var cancellables = Set<AnyCancellable>()

    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                                              span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))

        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

        $lastLocation
            .receive(on: DispatchQueue.main)
            .sink { [weak self] location in
                guard let self = self else { return }
                if let location = location {
                    self.updateCoordinateRegion(with: location)
                }
            }
            .store(in: &cancellables)
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
        DispatchQueue.global(qos: .userInitiated).async {
            if let location = locations.last {
                DispatchQueue.main.async { [weak self] in
                    self?.lastLocation = location
                }
                self.updateCoordinateRegion(with: location)
            }
        }
    }

    private func updateCoordinateRegion(with location: CLLocation) {
        DispatchQueue.main.async { [weak self] in
            self?.coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
            self?.currentLocationAnnotation = CurrentLocationAnnotation(coordinate: location.coordinate)
        }
    }
}
