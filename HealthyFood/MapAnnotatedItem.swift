//
//  MapAnnotatedItem.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 18/1/2025.
//

import Foundation
import MapKit
import SwiftUI

//Map structure
struct MapAnnotationItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
    var tintColor: Color
    var restaurant: HealthyRestaurants
}
