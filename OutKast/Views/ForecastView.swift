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
    @Environment(\.scenePhase) private var scenePhase
    
    let weatherManager = WeatherManager.shared
    
    @State private var selectedCity: City?
    @State private var currentWeather: CurrentWeather?
    @State private var isLoading = false
    @State private var isMapViewPresented = false
    @State private var timeZone: TimeZone = .current
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                TabView {
                    VStack {
                        if let selectedCity {
                            if isLoading {
                                ProgressView()
                                Text("Fetching Weather...")
                            } else {
                                Text(selectedCity.name)
                                    .font(.title)
                                
                                if let currentWeather {
                                    Text(currentWeather.date.localDate(for: timeZone))
                                    Text(currentWeather.date.localTime(for: timeZone))
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
                                    
                                    Spacer()
                                    
                                    //                        AttributionView()
                                    //                            .tint(.white)
                                }
                            }
                        }
                    }
                    .padding()
                    .background {
                        if selectedCity != nil,
                           let condition = currentWeather?.condition {
                            BackgroundView(condition: condition)
                        }
                    }
                    .preferredColorScheme(.dark)
                    .onChange(of: scenePhase) {
                        if scenePhase == .active {
                            selectedCity = locationManager.currentLocation
                            if let selectedCity {
                                Task {
                                    await fetchWeather(for: selectedCity)
                                }
                            }
                        }
                    }
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
    
    func fetchWeather(for city: City) async {
        isLoading = true
        Task.detached { @MainActor in
            currentWeather = await weatherManager.currentWeather(for: city.clLocation)
            timeZone = await locationManager.getTimeZone(for: city.clLocation)
        }
        isLoading = false
    }
}

#Preview {
    ForecastView()
        .environment(LocationManager())
}
