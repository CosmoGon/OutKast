//
//  OutKastApp.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 27.11.2024.
//

import SwiftUI

@main
struct OutKastApp: App {
    @State private var locationManager = LocationManager()
    @State private var store = DataStore()
    
    var body: some Scene {
        WindowGroup {
            if locationManager.isAuthorized {
                MainScreenView()
                    .onAppear {
                        print(URL.documentsDirectory.path())
                    }
            } else {
                LocationDeniedView()
            }
        }
        .environment(locationManager)
        .environment(store)
    }
}
