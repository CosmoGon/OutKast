//
//  HourlyForecastView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 28.11.2024.
//

import SwiftUI
import WeatherKit

struct HourlyForecastView: View {
    let weatherManager = WeatherManager.shared
    let hourlyForecast: Forecast<HourWeather>
    let timezone: TimeZone
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Forecast for the next 24 hours.")
                .font(.system(size: 15))
                .fontWeight(.medium)
                .opacity(0.9)
                .foregroundColor(.white)
                .padding(.horizontal, 15)
                .padding(.top, 10)
            
            Divider()
                .frame(height: 1)
                .overlay(Color.white.opacity(0.5))
                .padding(.leading)
                .padding(.top, 5)
                .padding(.bottom, -10)
            
            ScrollView(.horizontal) {
                HStack(spacing: 15) {
                    ForEach(Array(hourlyForecast.enumerated()), id: \.element.date) { index, hour in
                        VStack(spacing: 0) {
                            Text(index == 0 ? "Now" : hour.date.localTime(for: timezone))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            Image(systemName: hour.symbolName)
                                .renderingMode(.original)
                                .symbolVariant(.fill)
                                .font(.system(size: 22))
                                .padding(.bottom,3)
                            
                            if hour.precipitationChance > 0 {
                                Text("\((hour.precipitationChance * 100).formatted(.number.precision(.fractionLength(0))))%")
                                    .foregroundStyle(.cyan)
                                    .bold()
                            }
                            Spacer()
                            
                            Text(weatherManager.temperatureFormatter.string(from: hour.temperature))
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                        }
                    }
                }
                .font(.system(size: 13))
                .frame(height: 100)
            }
        }
        .contentMargins(.all, 15, for: .scrollContent)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.secondary.opacity(0.2)))
    }
}
