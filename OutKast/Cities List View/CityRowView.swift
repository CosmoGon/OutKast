//
//  CityRowView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 28.11.2024.
//

import SwiftUI
import WeatherKit

struct CityRowView: View {
    let weatherManager = WeatherManager.shared
    @Environment(LocationManager.self) var locationManager
    @State private var currentWeather: CurrentWeather?
    @State private var hourlyForecast: Forecast<HourWeather>?
    @State private var isLoading = false
    @State private var timezone: TimeZone = .current
    
    let city: City
    
    var highTemperature: String? {
        if let high = hourlyForecast?.map({ $0.temperature }).max() {
            return weatherManager.temperatureFormatter.string(from: high)
        }
        return nil
    }
    
    var lowTemperature: String? {
        if let low = hourlyForecast?.map({ $0.temperature }).min() {
            return weatherManager.temperatureFormatter.string(from: low)
        }
        return nil
    }
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else if let currentWeather {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(city.name)
                                .font(.system(size: 22))
                                .bold()
                                .scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                            
                            Text(currentWeather.date.localTime(for: timezone))
                                .font(.system(size: 13))
                                .fontWeight(.semibold)
                        }
                        Spacer()
                        let temp = weatherManager.temperatureFormatter.string(from: currentWeather.temperature)
                        Text(temp)
                            .font(.system(size: 45))
                            .fontWeight(.light)
                            .fixedSize(horizontal: true, vertical: true)
                    }
                    Spacer()
                    HStack {
                        Text(currentWeather.condition.description)
                            .font(.system(size: 13))
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        if let highTemperature, let lowTemperature {
                            Text("H: \(highTemperature)  L: \(lowTemperature)")
                                .font(.system(size: 13))
                                .fontWeight(.medium)
                        }
                    }
                }
                .padding()
                .padding(.top, -10)
                .frame(maxWidth: .infinity)
            }
        }
        .background {
            BackgroundView(condition: currentWeather?.condition ?? .clear)
        }
        .task(id: city) {
            await fetchWeather(for: city)
        }
    }
    
    func fetchWeather(for city: City) async {
        isLoading = true
        defer { isLoading = false }
        
        let weatherTask = Task { @MainActor in
            currentWeather = await weatherManager.currentWeather(for: city.clLocation)
            timezone = await locationManager.getTimezone(for: city.clLocation)
            hourlyForecast = await weatherManager.hourlyForecast(for: city.clLocation)
        }
        
        await weatherTask.value
    }
}

#Preview {
    CityRowView(city: City.mockCurrent)
        .environment(LocationManager())
}
