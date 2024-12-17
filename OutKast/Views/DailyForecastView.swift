//
//  DailyForecastView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 29.11.2024.
//

import SwiftUI
import WeatherKit

struct DailyForecastView: View {
    let dailyForecast: Forecast<DayWeather>
    let timezone: TimeZone
    
    @State private var barWidth: Double = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            let maxDayTemp = dailyForecast.map{$0.highTemperature.value}.max() ?? 0
            let minDayTemp = dailyForecast.map{$0.lowTemperature.value}.min() ?? 0
            let tempRange = maxDayTemp - minDayTemp
            
            HStack {
                Image(systemName: "calendar")
                    .font(.system(size: 14))
                    .bold()
                    .foregroundColor(.white)
                    .opacity(0.5)
                
                Text("10-Day Forecast".uppercased())
                    .font(.system(size: 14))
                    .bold()
                    .foregroundColor(.white)
                    .opacity(0.7)
            }
            
            Divider()
                .frame(height: 1)
                .overlay(Color.white.opacity(0.5))
                .padding(.horizontal, 2)
            
            ForEach(Array(dailyForecast.enumerated()), id: \.element.date) { index, day in
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
                        .frame(width: 75)
                        
                        Text("\(Int(day.lowTemperature.value))°")
                            .font(.system(size: 20, weight: .medium))
                            .opacity(0.6)
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
                        
                        Text("\(Int(day.highTemperature.value))°")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.white)
                            .frame(width: 50)
                    }
                } label: {
                    let isToday = Calendar.current.isDateInToday(day.date)
                    Text(isToday ? "Today" : day.date.localWeekDay(for: timezone))
                        .font(.system(size: 20, weight: .medium))
                        .frame(width: 60, alignment: .leading)
                }
                .frame(height: 35)
                
                if index < dailyForecast.count - 1 {
                    Divider()
                        .frame(height: 1)
                        .overlay(Color.white.opacity(0.5))
                        .padding(.horizontal, 2)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(.secondary.opacity(0.2)))
    }
}
