//
//  BackgroundView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 28.11.2024.
//

import SwiftUI
import WeatherKit

struct BackgroundView: View {
    let condition: WeatherCondition
    
    var body: some View {
        Image(condition.rawValue)
            .blur(radius: 5)
            .colorMultiply(.white.opacity(0.8))
    }
}

#Preview {
    BackgroundView(condition: .cloudy)
}
