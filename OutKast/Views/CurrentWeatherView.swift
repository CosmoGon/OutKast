//
//  CurrentWeatherView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 28.11.2024.
//

import SwiftUI
import WeatherKit

struct CurrentWeatherView: View {
    let weatherManager = WeatherManager.shared
    let currentWeather: CurrentWeather
    let highTemperature: String?
    let lowTemperature: String?
    let timezone: TimeZone
    
    
    var body: some View {
        let temp = weatherManager.temperatureFormatter.string(from: currentWeather.temperature)
        
        VStack {
            Text(temp)
                .font(.system(size: 100))
                .fontWeight(.thin)
            
            Text(currentWeather.condition.description)
                .font(.title3)
            
            if let highTemperature, let lowTemperature {
                Text("H: \(highTemperature)  L: \(lowTemperature)")
                    .bold()
            }
        }
    }
}
