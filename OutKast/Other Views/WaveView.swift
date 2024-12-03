//
//  WaveView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 03.12.2024.
//

import SwiftUI
import UIKit

struct WaveView: View {
    let dayColor: LinearGradient
    let nightColor: Color
    let sunColor: Color
    let horizonColor: Color
    let waveStrokeWidth: CGFloat = 4.0
    let horizonStrokeWidth: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Wave()
                    .stroke(nightColor, lineWidth: waveStrokeWidth)
                
                Wave()
                    .stroke(dayColor, lineWidth: waveStrokeWidth)
                    .mask {
                        GeometryReader { innerProxy in
                            Rectangle().foregroundColor(.red)
                                .frame(width: innerProxy.size.width, height: innerProxy.size.height * 1.0)
                        }
                    }
                
                Rectangle()
                    .foregroundColor(horizonColor)
                    .frame(height: horizonStrokeWidth)
                    .position(CGPoint(x: proxy.size.width/2.0, y: proxy.size.height * 1.0))
                    .shadow(color: .gray.opacity(0.3), radius: 1.0)
                
                Circle()
                    .frame(width: 10)
                    .foregroundColor(sunColor)
                    .shadow(color:sunColor ,radius: 5)
                    .position(Wave.point(
                        for: proxy.size.width/2,
                        in: CGRect(origin: CGPoint.zero, size: proxy.size)))
                
            }
        }
    }
}

struct Wave: Shape {
    
    let resolution: Int = 10
    let amplitude: Int = 1
    
    static func point(for x: CGFloat, in rect: CGRect) -> CGPoint {
        let frequency = 1 * (2 * 3.1415)
        let wavelength = rect.width / CGFloat(frequency)
        let relativeX = x / wavelength
        let y = (cos(relativeX) * rect.height/2) + rect.maxY
        
        return CGPoint(x: x, y: y)
    }
    
    func path(in rect: CGRect) -> Path {
        
        let frequency = 1 * (2 * 3.1415)
        let width = rect.width
        let wavelength = rect.width / CGFloat(frequency)
        
        let startPoint = CGPoint(x: rect.minX, y:rect.maxY)
        
        let path = UIBezierPath()
        
        path.move(to: startPoint)
        
        for x in stride(from: 0, through: width, by: 1) {
            
            let relativeX = x / wavelength
            let y = (cos(relativeX) * rect.height/2) + startPoint.y
            let point = CGPoint(x: x, y: y)
            
            if x == 0 {
                path.move(to: point)
                continue
            }
            path.addLine(to: point)
            
        }
        
        return Path(path.cgPath)
    }
}

#Preview {
    WaveView(
        dayColor: LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.5), Color.white.opacity(0.8)]), startPoint: .bottom, endPoint: .top),
        nightColor: Color(red: 0.28, green: 0.45, blue: 0.63).opacity(0.7),
        sunColor: .white,
        horizonColor: Color(.white)
    )
}

