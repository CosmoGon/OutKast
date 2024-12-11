//
//  ContentView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 27.11.2024.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct MainScreenView: View {
    @Environment(LocationManager.self) var locationManager
    
    @State private var selectedCity: City?
    
    @State private var isMapViewPresented = false
    
    let weatherManager = WeatherManager.shared
    
    @State private var currentWeather: CurrentWeather?
    @State private var hourlyForecast: Forecast<HourWeather>?
    @State private var dailyForecast: Forecast<DayWeather>?
    @State private var isLoading = false
    @State private var showCityList = false
    @State private var timezone: TimeZone = .current
    
    var highTemperature: String? {
        if let high = hourlyForecast?.map({$0.temperature}).max() {
            return weatherManager.temperatureFormatter.string(from: high)
        } else {
            return nil
        }
    }
    
    var lowTemperature: String? {
        if let low = hourlyForecast?.map({$0.temperature}).min() {
            return weatherManager.temperatureFormatter.string(from: low)
        } else {
            return nil
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                TabView {
                    ForecastView(
                        selectedCity: $selectedCity,
                        currentWeather: $currentWeather,
                        hourlyForecast: $hourlyForecast,
                        dailyForecast: $dailyForecast,
                        isLoading: $isLoading,
                        timezone: $timezone
                    )
                    .tabItem {
                        Label("", systemImage: "location.fill")
                    }
                }
                .tint(.white)
                
                HStack {
                    Button(action: {
                        isMapViewPresented.toggle()
                    }) {
                        Label("", systemImage: "map")
                            .foregroundColor(.white)
                            .font(.system(size: 22))
                            .padding()
                    }
                    .fullScreenCover(isPresented: $isMapViewPresented) {
                        MapView()
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        CitiesListView(currentLocation: locationManager.currentLocation, selectedCity: $selectedCity)
                    } label: {
                        Label("", systemImage: "list.bullet")
                            .foregroundColor(.white)
                            .font(.system(size: 22))
                            .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    MainScreenView()
        .environment(LocationManager())
        .environment(DataStore(forPreviews: true))
}
