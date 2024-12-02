//
//  City.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 27.11.2024.
//

import Foundation
import CoreLocation

struct City: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var clLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
    
    static var cities: [City] {
        [
            .init(name: "Paris, France", latitude: 48.856788, longitude: 2.351077),
            .init(name: "Sydney, Australia", latitude: -33.872710, longitude: 151.205694),
            .init(name: "Washington D.C., USA", latitude: 38.895438, longitude: -77.031281)
        ]
    }
    
    static var mockCurrent: City {
        .init(name: "Priponesti", latitude: 46.088036, longitude: 27.438486)
    }
}
