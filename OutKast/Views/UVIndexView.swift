//
//  UVIndexView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 03.12.2024.
//

import SwiftUI
import WeatherKit

struct UVIndexView: View {
    let currentWeather: CurrentWeather
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 4) {
                Image(systemName: "sun.max.fill")
                    .font(Font.system(size: 13))
                    .foregroundColor(.white)
                    .shadow(color: .gray.opacity(0.2), radius: 1.0)
                    .opacity(0.5)
                
                Text("UV Index".uppercased())
                    .font(Font.system(size: 13))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .shadow(color: .gray.opacity(0.2), radius: 1.0)
                    .opacity(0.5)
            }
            .padding(.top, -5)
            .padding(.bottom, 10)
            
            Text("\(currentWeather.uvIndex.value, specifier: "%.0f")") // UV index value
                .foregroundColor(.white)
                .font(Font.system(size: 32))
                .fontWeight(.medium)
                .shadow(color: .gray.opacity(0.2), radius: 1.0)
                .padding(.bottom, -5)
            
            Text("Moderate") // Index rating
                .foregroundColor(.white)
                .font(Font.system(size: 22))
                .fontWeight(.semibold)
                .shadow(color: .gray.opacity(0.2), radius: 1.0)
            
            Spacer()
            
            ProgressView(value: 0)
                .progressViewStyle(RangedProgressView(range: 0...1.0, foregroundColor: AnyShapeStyle(uvGradient), backgroundColor: Color(red: 0.54, green: 0.77, blue: 0.99)))
                .frame(maxHeight: 5.0)
            
            Spacer()
            
            Text("Use sun protection 11AM-4PM.") // Recomandation
                .foregroundColor(.white)
                .font(Font.system(size: 14))
                .fontWeight(.medium)
                .shadow(color: .gray.opacity(0.2), radius: 1.0)
        }
        .padding(15.0)
        .background(RoundedRectangle(cornerRadius: 20).fill(.secondary.opacity(0.2)))
        .cornerRadius(15)
    }
    
    var uvGradient: LinearGradient {
        return LinearGradient(colors: [
            .green,
            .yellow,
            .orange,
            .red,
            .purple
        ], startPoint: .leading, endPoint: .trailing)
    }
}


//#Preview {
//    UVIndexView()
//}
