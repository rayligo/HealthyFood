//
//  MapViewTests.swift
//  HealthyFoodTests
//
//  Created by Li Yiu Yeung  on 24/1/2025.
//

import Foundation
import XCTest
import SwiftUI
import MapKit
import CoreLocation
@testable import HealthyFood

class CurrentLocationAnnotationTests: XCTestCase {
    func testInitialization() {
        let coordinate = CLLocationCoordinate2D(latitude: 22.4790, longitude: 114.0450)
        let annotation = CurrentLocationAnnotation(coordinate: coordinate)
        
        XCTAssertEqual(annotation.coordinate.latitude, 22.4790)
        XCTAssertEqual(annotation.coordinate.longitude, 114.0450)
    }
}

