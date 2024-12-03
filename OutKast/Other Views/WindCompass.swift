//
//  WindCompass.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 03.12.2024.
//

import SwiftUI

struct WindCompass: View {
    var windDirection: String
    
    var body: some View {
        VStack {
            ZStack {
                // Lines with thickness for cardinal directions
                ForEach(0..<360) { angle in
                    Line(angle: Double(angle), radius: 62)
                        .stroke(Color.white, lineWidth: angle % 45 == 0 ? 2 : 0.5) // Adjusted line width
                        .rotationEffect(Angle(degrees: Double(angle)))
                        .opacity(0.3)
                        .padding(.horizontal, -70)
                }
                
                // Thinner lines for other directions
                ForEach(0..<360) { angle in
                    Line(angle: Double(angle), radius: 62)
                        .stroke(Color.white, lineWidth: angle % 15 == 0 ? 1 : 0.5) // Adjusted line width
                        .rotationEffect(Angle(degrees: Double(angle)))
                        .opacity(0.3)
                        .padding(.horizontal, -70)
                }
                
                // Triangle for North direction
                Triangle()
                    .fill(Color.white)
                    .frame(width: 7, height: 7)
                    .rotationEffect(Angle(degrees: 0))
                    .offset(y: -59)
                    .opacity(0.8)
                
                // Cardinal directions
                Text("N")
                    .foregroundColor(.white)
                    .offset(y: -47)
                    .font(Font.system(size: 14))
                    .fontWeight(.medium)
                    .opacity(0.8)
                
                Text("S")
                    .foregroundColor(.white)
                    .offset(y: 47)
                    .font(Font.system(size: 14))
                    .fontWeight(.medium)
                    .opacity(0.8)
                
                Text("E")
                    .foregroundColor(.white)
                    .offset(x: 47)
                    .font(Font.system(size: 14))
                    .fontWeight(.medium)
                    .opacity(0.8)
                
                Text("W")
                    .foregroundColor(.white)
                    .offset(x: -47)
                    .font(Font.system(size: 14))
                    .fontWeight(.medium)
                    .opacity(0.8)
                
                ArrowLine(angle: 0)
                    .stroke(Color.white, lineWidth: 110)
                    .rotationEffect(Angle(degrees: 25))
                
                Circle()
                    .stroke(Color.white, lineWidth: 2)
                    .frame(width: 6, height: 6)
                    .offset(x: 27, y: -52)
                
                Arrow()
                    .fill(Color.white)
                    .frame(width: 9, height: 20)
                    .rotationEffect(Angle(degrees: 210))
                    .offset(x: -20, y: 49)
                
                Circle()
                    .fill(Color(.gray))
                    .frame(width: 65, height: 65, alignment: .center)
                    .shadow(radius: 2)
                
                Text(windDirection)
                    .foregroundColor(.white)
                    .font(Font.system(size: 20))
                    .fontWeight(.semibold)
            }
        }
    }
}

struct Line: Shape {
    var angle: Double
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let start = CGPoint(x: rect.midX + cos(CGFloat(angle) * .pi / 180) * radius, y: rect.midY + sin(CGFloat(angle) * .pi / 180) * radius)
        let end = CGPoint(x: rect.midX + cos(CGFloat(angle) * .pi / 180) * (radius - 7), y: rect.midY + sin(CGFloat(angle) * .pi / 180) * (radius - 7))
        path.move(to: start)
        path.addLine(to: end)
        return path
    }
}

struct ArrowLine: Shape {
    var angle: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius: CGFloat = 4
        let start = CGPoint(x: rect.midX + cos(CGFloat(angle) * .pi / 180) * radius, y: rect.midY + sin(CGFloat(angle) * .pi / 180) * radius)
        let end = CGPoint(x: rect.midX + cos(CGFloat(angle) * .pi / 180) * (radius - 2), y: rect.midY + sin(CGFloat(angle) * .pi / 180) * (radius - 2))
        path.move(to: start)
        path.addLine(to: end)
        return path
    }
}


struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    WindCompass(windDirection: "")
}

