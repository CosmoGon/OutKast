//
//  DailyForecastView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 29.11.2024.
//

import SwiftUI
import WeatherKit

struct DailyForecastView: View {
    let weatherManager = WeatherManager.shared
    let dailyForecast: Forecast<DayWeather>
    let timezone: TimeZone
    
    @State private var barWidth: Double = 0
    
    var body: some View {
        VStack {
            let maxDayTemp = dailyForecast.map{$0.highTemperature.value}.max() ?? 0
            let minDayTemp = dailyForecast.map{$0.lowTemperature.value}.min() ?? 0
            let tempRange = maxDayTemp - minDayTemp
            
            ForEach(dailyForecast, id: \.date) { day in
                LabeledContent {
                    HStack(spacing: 0) {
                        VStack {
                            Image(systemName: day.symbolName)
                                .renderingMode(.original)
                                .symbolVariant(.fill)
                                .font(.system(size: 20))
                            
                            if day.precipitationChance > 0 {
                                Text("\((day.precipitationChance * 100).formatted(.number.precision(.fractionLength(0))))%")
                                    .font(.system(size: 10))
                                    .foregroundStyle(.cyan)
                                    .bold()
                            }
                        }
                        .frame(width: 25)
                        
                        Text(weatherManager.temperatureFormatter.string(from: day.lowTemperature))
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 50)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.secondary.opacity(0.3))
                            .frame(height: 5)
                            .readSize { size in
                                barWidth = size.width
                            }
                            .overlay {
                                let degreeFactor = barWidth / tempRange
                                let dayRangeWidth = (day.highTemperature.value - day.lowTemperature.value) * degreeFactor
                                let xOffset = (day.lowTemperature.value - minDayTemp) * degreeFactor
                                
                                HStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(
                                                    colors: [
                                                        .green,
                                                        .orange
                                                    ]
                                                ),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .frame(width: dayRangeWidth, height: 5)
                                    Spacer()
                                }
                                .offset(x: xOffset)
                            }
                        
                        Text(weatherManager.temperatureFormatter.string(from: day.highTemperature))
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 50)
                    }
                } label: {
                    Text(day.date.localWeekDay(for: timezone))
                        .frame(width: 40, alignment: .leading)
                }
                .frame(height: 35)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(.secondary.opacity(0.2)))
    }
}
