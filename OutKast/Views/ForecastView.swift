//
//  ContentView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 27.11.2024.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct ForecastView: View {
    @Environment(LocationManager.self) var locationManager
    
    let weatherManager = WeatherManager.shared
    
    @State private var selectedCity: City?
    @State private var currentWeather: CurrentWeather?
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            if let selectedCity {
                if isLoading {
                    ProgressView()
                    Text("Fetching Weather...")
                } else {
                    Text(selectedCity.name)
                        .font(.title)
                    
                    if let currentWeather {
                        Text(Date.now.formatted(date: .abbreviated, time: .omitted))
                        Text(Date.now.formatted(date: .omitted, time: .shortened))
                        Image(systemName: currentWeather.symbolName)
                            .renderingMode(.original)
                            .symbolVariant(.fill)
                            .font(.system(size: 60.0, weight: .bold))
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20.0)
                                    .fill(.secondary.opacity(0.2))
                            )
                        
                        let temp = weatherManager.temperatureFormatter.string(from: currentWeather.temperature)
                        
                        Text(temp)
                            .font(.title2)
                        
                        Text(currentWeather.condition.description)
                            .font(.title3)
                        
                        AttributionView()
                    }
                }
            }
        }
        .padding()
        .task(id: locationManager.currentLocation) {
            if let currentLocaion = locationManager.currentLocation, selectedCity == nil {
                selectedCity = currentLocaion
            }
        }
        .task(id: selectedCity) {
            if let selectedCity {
                await fetchWeather(for: selectedCity)
            }
        }
    }
    
    func fetchWeather(for city: City) async {
        isLoading = true
        Task.detached { @MainActor in
            currentWeather = await weatherManager.currentWeather(for: city.clLocation)
        }
        isLoading = false
    }
}

#Preview {
    ForecastView()
        .environment(LocationManager())
}
