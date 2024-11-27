//
//  City.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 27.11.2024.
//

import Foundation
import CoreLocation

struct City: Identifiable, Hashable {
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
}
