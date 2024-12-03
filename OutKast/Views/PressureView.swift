//
//  PressureView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 03.12.2024.
//

import SwiftUI
import WeatherKit

struct PressureView: View {
    let currentWeather: CurrentWeather
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 4) {
                Image(systemName: "gauge.with.dots.needle.100percent")
                    .font(Font.system(size: 13))
                    .foregroundColor(.white)
                    .shadow(color: .gray.opacity(0.2), radius: 1.0)
                    .opacity(0.5)
                
                Text("Pressure".uppercased())
                    .font(Font.system(size: 13))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .shadow(color: .gray.opacity(0.2), radius: 1.0)
                    .opacity(0.5)
            }
            .padding(.top, -5)
            .padding(.bottom, 10)
            
            Spacer()
            
            ZStack {
                PressureScaleView()
                
                VStack {
                    Image(systemName: "arrow.down")
                        .font(Font.system(size: 15))
                        .fontWeight(.bold)
                    
                    Text("\(Int(currentWeather.pressure.value))")
                        .font(Font.system(size: 15))
                        .fontWeight(.bold)
                    
                    Text("hPa")
                        .font(Font.system(size: 11))
                }
                .foregroundColor(.white)
                .padding(.top, -15)
            }
            
            Spacer()
            
        }
        .padding(15.0)
        .background(RoundedRectangle(cornerRadius: 20).fill(.secondary.opacity(0.2)))

        .cornerRadius(15)
    }
}

//#Preview {
//    PressureView()
//}
