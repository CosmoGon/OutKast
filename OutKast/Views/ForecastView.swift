//
//  ForecastView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 10.12.2024.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct ForecastView: View {
    @Environment(LocationManager.self) var locationManager
    @Environment(\.scenePhase) private var scenePhase
    
    let weatherManager = WeatherManager.shared
    
    @Binding var selectedCity: City?
    @Binding var currentWeather: CurrentWeather?
    @Binding var hourlyForecast: Forecast<HourWeather>?
    @Binding var dailyForecast: Forecast<DayWeather>?
    @Binding var isLoading: Bool
    @Binding var timezone: TimeZone
    
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
        ScrollView(showsIndicators: false) {
            VStack {
                if let selectedCity {
                    if isLoading {
                        ProgressView()
                        Text("Fetching Weather...")
                    } else {
                        Text(selectedCity.name)
                            .font(.title)
                            .padding(.top, 30)
                        
                        if let currentWeather {
                            CurrentWeatherView(
                                currentWeather: currentWeather,
                                highTemperature: highTemperature,
                                lowTemperature: lowTemperature,
                                timezone: timezone
                            )
                            .padding(.bottom, 70)
                        }
                        
                        if let hourlyForecast {
                            HourlyForecastView(
                                hourlyForecast: hourlyForecast,
                                timezone: timezone
                            )
                        }
                        
                        if let dailyForecast {
                            DailyForecastView(dailyForecast: dailyForecast, timezone: timezone)
                        }
                        
                        AirQualityView()
                        
                        HStack {
                            if let currentWeather {
                                FeelsLikeView(currentWeather: currentWeather)
                                    .aspectRatio(1.0, contentMode: .fill)
                            }
                            
                            if let currentWeather {
                                UVIndexView(currentWeather: currentWeather)
                                    .aspectRatio(1.0, contentMode: .fill)
                            }
                        }
                        
                        if let currentWeather {
                            WindView(currentWeather: currentWeather)
                        }
                        
                        HStack {
                            SunTrackerView()
                                .aspectRatio(1.0, contentMode: .fill)
                            
                            PrecipitationView()
                                .aspectRatio(1.0, contentMode: .fill)
                        }
                        
                        HStack {
                            if let currentWeather {
                                VisibilityView(currentWeather: currentWeather)
                                    .aspectRatio(1.0, contentMode: .fill)
                            }
                            
                            if let currentWeather {
                                HumidityView(currentWeather: currentWeather)
                                    .aspectRatio(1.0, contentMode: .fill)
                            }
                        }
                        
                        HStack {
                            AveragesView()
                                .aspectRatio(1.0, contentMode: .fill)
                            
                            if let currentWeather {
                                PressureView(currentWeather: currentWeather)
                                    .aspectRatio(1.0, contentMode: .fill)
                            }
                        }
                    }
                }
            }
        }
        .contentMargins(.all, 15, for: .scrollContent)
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
            if let currentLocation = locationManager.currentLocation, selectedCity == nil {
                selectedCity = currentLocation
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
            timezone = await locationManager.getTimezone(for: city.clLocation)
            hourlyForecast = await weatherManager.hourlyForecast(for: city.clLocation)
            dailyForecast = await weatherManager.dailyForecast(for: city.clLocation)
        }
        isLoading = false
    }
}

//#Preview {
//    ForecastView()
//        .environment(LocationManager())
//        .environment(DataStore(forPreviews: true))
//}
