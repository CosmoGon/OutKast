//
//  RangedProgressView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 03.12.2024.
//

import SwiftUI

struct RangedProgressView: ProgressViewStyle {
    let range: ClosedRange<Double>
    let foregroundColor: AnyShapeStyle
    let backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        return GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(backgroundColor)
                
                Capsule()
                    .fill(foregroundColor)
                    .frame(width: proxy.size.width * fillWidthScale)
                    .offset(x: proxy.size.width * range.lowerBound)
                
                Circle()
                    .foregroundColor(backgroundColor)
                    .frame(width: proxy.size.width + 4.0, height: proxy.size.height + 4.0)
                    .position(x: proxy.size.width * (configuration.fractionCompleted ?? 0.0), y: proxy.size.height/2.0)
                
                Circle()
                    .foregroundColor(.white)
                    .position(x: proxy.size.width * (configuration.fractionCompleted ?? 0.0), y: proxy.size.height/2.0)
            }
            .clipped()
        }
    }
    
    var fillWidthScale: Double {
        let normalizedRange = range.upperBound - range.lowerBound
        return Double(normalizedRange)
    }
}

#Preview {
    ScrollView {
        VStack {
            ForEach(0...8, id: \.self) { value in
                let range = 0.0...(Double(value)/10.0)
                let gradient = LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing)
                ProgressView(value: 0.5)
                    .frame(height: 4)
                    .progressViewStyle(RangedProgressView(range: range,
                                                          foregroundColor: AnyShapeStyle(gradient),
                                                          backgroundColor: .purple))
                    .padding()
            }
        }
    }
}

