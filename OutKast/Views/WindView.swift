//
//  WindView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 03.12.2024.
//

import SwiftUI
import WeatherKit

struct WindView: View {
    let currentWeather: CurrentWeather
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HStack {
                Image(systemName: "wind")
                
                Text("Wind".uppercased())
            }
            .foregroundColor(.white)
            .font(Font.system(size: 13))
            .fontWeight(.medium)
            .shadow(color: .gray.opacity(0.2), radius: 1.0)
            .padding(.bottom, 20)
            .padding(.top, -5)
            .opacity(0.5)
            
            HStack {
                VStack(alignment: .leading, spacing: 0.0) {
                    HStack {
                        Text("\(Int(currentWeather.wind.speed.value))")
                            .foregroundColor(.white)
                            .font(Font.system(size: 35))
                            .fontWeight(.medium)
                            .shadow(color: .gray.opacity(0.2), radius: 1.0)
                        
                        VStack {
                            Text("KMH")
                                .foregroundColor(.white)
                                .font(Font.system(size: 13))
                                .fontWeight(.medium)
                                .opacity(0.5)
                            
                            Text("Wind")
                                .foregroundColor(.white)
                                .font(Font.system(size: 14))
                                .fontWeight(.medium)
                        }
                    }
                    .padding(.leading, 6)
                    .padding(.bottom, 10)
                    
                    Divider()
                    
                    HStack {
                        if let gust = currentWeather.wind.gust {
                                Text("\(Int(gust.value))") // Display the gust value
                                    .foregroundColor(.white)
                                    .font(Font.system(size: 35))
                                    .fontWeight(.medium)
                                    .shadow(color: .gray.opacity(0.2), radius: 1.0)
                            } else {
                                Text("N/A") // Fallback text if gust data is unavailable
                                    .foregroundColor(.white)
                                    .font(Font.system(size: 35))
                                    .fontWeight(.medium)
                                    .shadow(color: .gray.opacity(0.2), radius: 1.0)
                            }
                        
                        VStack {
                            Text("KMH")
                                .foregroundColor(.white)
                                .font(Font.system(size: 13))
                                .fontWeight(.medium)
                                .opacity(0.5)
                            
                            Text("Gusts")
                                .foregroundColor(.white)
                                .font(Font.system(size: 14))
                                .fontWeight(.medium)
                        }
                    }
                    .padding(.leading, 6)
                    .padding(.top, 10)
                }
                .padding(.bottom, 15)
                
                WindCompass(windDirection: getWindDirection(degrees: "\(currentWeather.wind.direction.value)"))
                    .padding(.bottom, 15)
                    .padding(.trailing, -30)
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 20).fill(.secondary.opacity(0.2)))
        .cornerRadius(15)
    }
    
    // Helper function to convert wind degrees to direction
    func getWindDirection(degrees: String) -> String {
        guard let windDegrees = Double(degrees) else {
            return "N/A"
        }
        
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"]
        let index = Int((windDegrees + 22.5) / 45) % 8
        return directions[index]
    }
}

//#Preview {
//    WindView()
//}

