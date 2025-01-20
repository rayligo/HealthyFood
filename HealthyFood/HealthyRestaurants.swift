//
//  HealthyRestaurants.swift
//  HealthyFood
//
//  Created by Li Yiu Yeung  on 20/1/2025.
//

import Foundation
import MapKit

struct HealthyRestaurants: Identifiable {
 let id = UUID()
 let name : String
 var coordinate : CLLocationCoordinate2D
}

let restaurants = [
    HealthyRestaurants(name: "Kenko Syokuhin Ramen", coordinate: CLLocationCoordinate2D(latitude: 22.2849, longitude: 114.1549)),
    HealthyRestaurants(name: "Health Workshop", coordinate: CLLocationCoordinate2D(latitude: 22.341, longitude: 114.1875)),
    HealthyRestaurants(name: "Health Concept", coordinate: CLLocationCoordinate2D(latitude: 22.2825, longitude: 114.1545)),
    HealthyRestaurants(name: "Pololi Hawaiian Central", coordinate: CLLocationCoordinate2D(latitude: 22.2838, longitude: 114.1568)),
    HealthyRestaurants(name: "Knead Vegan Sheung Wan", coordinate: CLLocationCoordinate2D(latitude: 22.2879, longitude: 114.1529)),
    HealthyRestaurants(name: "Veda Vegetarian Central", coordinate: CLLocationCoordinate2D(latitude: 22.2800, longitude: 114.1570)),
    HealthyRestaurants(name: "Treehouse Central", coordinate: CLLocationCoordinate2D(latitude: 22.2797, longitude: 114.1602)),
    HealthyRestaurants(name: "Orka", coordinate: CLLocationCoordinate2D(latitude: 22.2822, longitude: 114.1570)),
    HealthyRestaurants(name: "Ovo Cafe", coordinate: CLLocationCoordinate2D(latitude: 22.2817, longitude: 114.1759)),
    HealthyRestaurants(name: "Locofama", coordinate: CLLocationCoordinate2D(latitude: 22.2847, longitude: 114.1467)),
    HealthyRestaurants(name: "Fivelements Sakti Elixir", coordinate: CLLocationCoordinate2D(latitude: 22.2785, longitude: 114.1828)),
    HealthyRestaurants(name: "Sevva", coordinate: CLLocationCoordinate2D(latitude: 22.2792, longitude: 114.1603)),
    HealthyRestaurants(name: "Green Common", coordinate: CLLocationCoordinate2D(latitude: 22.2831, longitude: 114.1540)),
    HealthyRestaurants(name: "Something Wild - The Farm", coordinate: CLLocationCoordinate2D(latitude: 22.3003, longitude: 114.1736)),
    HealthyRestaurants(name: "Guru’s Indian Restaurant", coordinate: CLLocationCoordinate2D(latitude: 22.2852, longitude: 114.1548)),
    HealthyRestaurants(name: "Soupday", coordinate: CLLocationCoordinate2D(latitude: 22.2830, longitude: 114.1777)),
    HealthyRestaurants(name: "Soup Plus", coordinate: CLLocationCoordinate2D(latitude: 22.3123, longitude: 114.1681)),
    HealthyRestaurants(name: "Veggie4Love", coordinate: CLLocationCoordinate2D(latitude: 22.345, longitude: 114.159)),
    HealthyRestaurants(name: "Magic Cleanse", coordinate: CLLocationCoordinate2D(latitude: 22.314, longitude: 114.169)),
    HealthyRestaurants(name: "Moment Organic Cafe", coordinate: CLLocationCoordinate2D(latitude: 22.317, longitude: 114.158)),
    HealthyRestaurants(name: "Maison Libanaise", coordinate: CLLocationCoordinate2D(latitude: 22.293, longitude: 114.165)),
    HealthyRestaurants(name: "Le Souk", coordinate: CLLocationCoordinate2D(latitude: 22.305, longitude: 114.150)),
    HealthyRestaurants(name: "Bellagio Cafe", coordinate: CLLocationCoordinate2D(latitude: 22.310, longitude: 114.172)),
    HealthyRestaurants(name: "O2 / Orka 2.0", coordinate: CLLocationCoordinate2D(latitude: 22.295, longitude: 114.169)),
    HealthyRestaurants(name: "Sunset Road", coordinate: CLLocationCoordinate2D(latitude: 22.326, longitude: 114.154)),
    HealthyRestaurants(name: "Weekend Afternoon Tea", coordinate: CLLocationCoordinate2D(latitude: 22.275, longitude: 114.172)),
    HealthyRestaurants(name: "No Meat September", coordinate: CLLocationCoordinate2D(latitude: 22.318, longitude: 114.159)),
    HealthyRestaurants(name: "Two Chefs’ Soup", coordinate: CLLocationCoordinate2D(latitude: 22.301, longitude: 114.156)),
    HealthyRestaurants(name: "Fresh Noodles", coordinate: CLLocationCoordinate2D(latitude: 22.320, longitude: 114.178)),
    HealthyRestaurants(name: "Orga Chef's Selection", coordinate: CLLocationCoordinate2D(latitude: 22.315, longitude: 114.167)),
    HealthyRestaurants(name: "Honest Food", coordinate: CLLocationCoordinate2D(latitude: 22.304, longitude: 114.151)),
    HealthyRestaurants(name: "Plant-Based Factory", coordinate: CLLocationCoordinate2D(latitude: 22.305, longitude: 114.174))
]

