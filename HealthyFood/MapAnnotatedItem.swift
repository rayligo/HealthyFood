//
//  MapAnnotatedItem.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 18/1/2025.
//

import Foundation
import MapKit

struct MapAnnotatedItem : Identifiable {
 let id = UUID()
 let name : String
 var coordinate : CLLocationCoordinate2D
}
