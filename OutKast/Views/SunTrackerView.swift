//
//  SunTrackerView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 03.12.2024.
//

import SwiftUI

struct SunTrackerView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HStack(spacing: 4) {
                Image(systemName: "sunset.fill")
                    .font(Font.system(size: 13))
                    .foregroundColor(.white)
                    .shadow(color: .gray.opacity(0.2), radius: 1.0)
                    .opacity(0.5)
                
                Text("Sunset".uppercased())
                    .font(Font.system(size: 13))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .shadow(color: .gray.opacity(0.2), radius: 1.0)
                    .opacity(0.5)
            }
            .padding(.top, 10)
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            Text("6:45PM") // Time of sunset
                .foregroundColor(.white)
                .font(Font.system(size: 32))
                .fontWeight(.medium)
                .shadow(color: .gray.opacity(0.2), radius: 1.0)
                .padding(.horizontal)
                .padding(.bottom, -10)
            
            Spacer()
            
            WaveView(dayColor: LinearGradient(
                gradient: Gradient(colors: [Color.white.opacity(0.5), Color.white.opacity(0.8)]),
                startPoint: .bottom,
                endPoint: .top
            ),
                     nightColor: Color(red: 0.28, green: 0.45, blue: 0.63).opacity(0.5),
                     sunColor: .white,
                     horizonColor: Color(.white).opacity(0.5))
            
            Spacer()
            
            Text("Sunrise: 7AM")
                .foregroundColor(.white)
                .font(Font.system(size: 14))
                .fontWeight(.medium)
                .shadow(color: .gray.opacity(0.2), radius: 1.0)
                .padding()
                .padding(.top, 5)
        }
        .background(RoundedRectangle(cornerRadius: 20).fill(.secondary.opacity(0.2)))
        .cornerRadius(15)
    }
}

#Preview {
    SunTrackerView()
}
