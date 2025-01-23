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
    HealthyRestaurants(name: "Healthy Bites", coordinate: CLLocationCoordinate2D(latitude: 22.3193, longitude: 114.1694)),
    HealthyRestaurants(name: "Green Plate", coordinate: CLLocationCoordinate2D(latitude: 22.3027, longitude: 114.1772)),
    HealthyRestaurants(name: "Nature's Harvest", coordinate: CLLocationCoordinate2D(latitude: 22.2855, longitude: 114.1589)),
    HealthyRestaurants(name: "Fresh Deli", coordinate: CLLocationCoordinate2D(latitude: 22.2793, longitude: 114.1628)),
    HealthyRestaurants(name: "Veggie Delight", coordinate: CLLocationCoordinate2D(latitude: 22.3364, longitude: 114.1746)),
    HealthyRestaurants(name: "Healthy Kitchen", coordinate: CLLocationCoordinate2D(latitude: 22.3964, longitude: 114.1095)),
    HealthyRestaurants(name: "Purely Green", coordinate: CLLocationCoordinate2D(latitude: 22.3242, longitude: 114.2128)),
    HealthyRestaurants(name: "Salad Heaven", coordinate: CLLocationCoordinate2D(latitude: 22.2908, longitude: 114.2045)),
    HealthyRestaurants(name: "Organic Eats", coordinate: CLLocationCoordinate2D(latitude: 22.2773, longitude: 114.1826)),
    HealthyRestaurants(name: "Vitality Cafe", coordinate: CLLocationCoordinate2D(latitude: 22.3069, longitude: 114.2486)),
    HealthyRestaurants(name: "Eco Meals", coordinate: CLLocationCoordinate2D(latitude: 22.3198, longitude: 114.2161)),
    HealthyRestaurants(name: "Whole Foods Bar", coordinate: CLLocationCoordinate2D(latitude: 22.3186, longitude: 114.1687)),
    HealthyRestaurants(name: "Healthy Choice", coordinate: CLLocationCoordinate2D(latitude: 22.3705, longitude: 114.1389)),
    HealthyRestaurants(name: "Nourish Spot", coordinate: CLLocationCoordinate2D(latitude: 22.3306, longitude: 114.1605)),
    HealthyRestaurants(name: "Balanced Bowl", coordinate: CLLocationCoordinate2D(latitude: 22.3196, longitude: 114.1717)),
    HealthyRestaurants(name: "Clean Eats", coordinate: CLLocationCoordinate2D(latitude: 22.3033, longitude: 114.1542)),
    HealthyRestaurants(name: "Lean Meals", coordinate: CLLocationCoordinate2D(latitude: 22.2853, longitude: 114.1382)),
    HealthyRestaurants(name: "The Green Fork", coordinate: CLLocationCoordinate2D(latitude: 22.479, longitude: 114.1576)),
    HealthyRestaurants(name: "Joyful Palace Banquet Hall", coordinate: CLLocationCoordinate2D(latitude: 22.4777, longitude: 114.04566)),
    HealthyRestaurants(name: "Macau Taipa Portuguese Restaurant", coordinate: CLLocationCoordinate2D(latitude: 22.477, longitude: 114.0455)),
    HealthyRestaurants(name: "New Bright Garden Seafood Restaurant", coordinate: CLLocationCoordinate2D(latitude: 22.478, longitude: 114.0452)),
    HealthyRestaurants(name: "Happy Forest Cafe", coordinate: CLLocationCoordinate2D(latitude: 22.478, longitude: 114.0460)),
    HealthyRestaurants(name: "Scenic Garden Country Club (Ting Lin Pavilion)", coordinate: CLLocationCoordinate2D(latitude: 22.478, longitude: 114.0458)),
    HealthyRestaurants(name: "Maxim's Restaurant", coordinate: CLLocationCoordinate2D(latitude: 22.478, longitude: 114.0453)),
    HealthyRestaurants(name: "Cafe de Coral", coordinate: CLLocationCoordinate2D(latitude: 22.479, longitude: 114.0451)),
    HealthyRestaurants(name: "Pacific Coffee", coordinate: CLLocationCoordinate2D(latitude: 22.478, longitude: 114.0454)),
    HealthyRestaurants(name: "CHICKEN FACTORY", coordinate: CLLocationCoordinate2D(latitude: 22.478, longitude: 114.0456))

]


