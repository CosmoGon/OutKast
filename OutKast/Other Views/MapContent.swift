//
//  MapContent.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 10.12.2024.
//

import SwiftUI
import MapKit

struct MapContent: View {
    @StateObject private var mapViewModel = MapViewModel()
    
    var body: some View {
        Map(coordinateRegion: $mapViewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            .mapStyle(.hybrid(elevation: .realistic))
            .onAppear {
                mapViewModel.checkIfLocationServicesIsEnabled()
            }
    }
}

#Preview {
    MapContent()
}
