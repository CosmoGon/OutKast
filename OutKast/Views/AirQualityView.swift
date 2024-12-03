//
//  AirQualityView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 03.12.2024.
//

import SwiftUI

struct AirQualityView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HStack {
                Image(systemName: "aqi.low")
                
                Text("Air quality".uppercased())
            }
            .foregroundColor(.white)
            .font(Font.system(size: 13))
            .fontWeight(.medium)
            .shadow(color: .gray.opacity(0.2), radius: 1.0)
            .padding(.bottom, 10)
            .padding(.top, -5)
            .opacity(0.5)
            
            Text("24 - Good")
                .foregroundStyle(.white)
                .font(Font.system(size: 24))
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            Text("Air quality index is 24, which is similar to yesterday at about this time.")
                .foregroundStyle(.white)
                .font(Font.system(size: 13))
                .fontWeight(.medium)
                .padding(.bottom, 32)
            
            ProgressView(value: 0)
                .progressViewStyle(RangedProgressView(range: 0...1.0, foregroundColor: AnyShapeStyle(uvGradient), backgroundColor: Color(red: 0.54, green: 0.77, blue: 0.99)))
                .frame(maxHeight: 5.0)
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.secondary.opacity(0.2)))
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

#Preview {
    AirQualityView()
}
