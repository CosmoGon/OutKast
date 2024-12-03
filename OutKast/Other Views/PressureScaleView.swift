//
//  PressureScaleView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 03.12.2024.
//

import SwiftUI

struct PressureScaleView: View {
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 20, height: 4)
                    .cornerRadius(4)
                    .offset(x: -48, y: 1) // Adjust the offset based on your requirement
                    .rotationEffect(.degrees(90))
                
                PressureScaleShape(scale: 0.8)
                    .stroke(Color.white, lineWidth: 2)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 30)
                    .padding(.bottom, 10)
                    .opacity(0.5)
            }
            
            HStack {
                Text("Low")
                    .foregroundColor(.white)
                    .font(Font.system(size: 14))
                    .fontWeight(.medium)
                    .shadow(color: .gray.opacity(0.2), radius: 1.0)
                
                Spacer()
                
                Text("High")
                    .foregroundColor(.white)
                    .font(Font.system(size: 14))
                    .fontWeight(.medium)
                    .shadow(color: .gray.opacity(0.2), radius: 1.0)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, -5)
            .foregroundColor(.white)
        }
    }
}

struct PressureScaleShape: Shape {
    var scale: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let centerX = rect.width / 2
        let centerY = rect.height / 2
        let radius = rect.width / 2 * scale
        
        var path = Path()
        
        for angle in stride(from: -30, through: 210, by: 8) {
            let radians = Angle(degrees: Double(angle)).radians
            let startX = centerX + cos(radians) * radius
            let startY = centerY - sin(radians) * radius // Flip the sin value
            let endX = centerX + cos(radians) * (radius - 12)
            let endY = centerY - sin(radians) * (radius - 12)
            
            path.move(to: CGPoint(x: startX, y: startY))
            path.addLine(to: CGPoint(x: endX, y: endY))
        }
        
        return path
    }
}

#Preview {
    PressureScaleView()
}

