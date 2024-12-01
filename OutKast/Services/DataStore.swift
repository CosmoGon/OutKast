//
//  DataStore.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 01.12.2024.
//

import Foundation

@Observable
class DataStore {
    var forPreviews: Bool
    var cities: [City] = []
    
    init(forPreviews: Bool = false) {
        self.forPreviews = forPreviews
        loadCities()
    }
    
    func loadCities() {
        if forPreviews {
            cities = City.cities
        } else {
            
        }
    }
}
