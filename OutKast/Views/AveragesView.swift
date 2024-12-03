//
//  AveragesView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 03.12.2024.
//

import SwiftUI

struct AveragesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 4) {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(Font.system(size: 13))
                    .foregroundColor(.white)
                    .shadow(color: .gray.opacity(0.2), radius: 1.0)
                    .opacity(0.5)
                
                Text("Averages".uppercased())
                    .font(Font.system(size: 13))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .shadow(color: .gray.opacity(0.2), radius: 1.0)
                    .opacity(0.5)
            }
            .padding(.top, -5)
            .padding(.bottom, 10)
            
            Text("-2º")
                .foregroundColor(.white)
                .font(Font.system(size: 32))
                .fontWeight(.medium)
                .shadow(color: .gray.opacity(0.2), radius: 1.0)
                .padding(.bottom, -5)
            
            Text("from average daily high")
                .foregroundColor(.white)
                .font(Font.system(size: 15))
                .fontWeight(.medium)
                .shadow(color: .gray.opacity(0.2), radius: 1.0)
                .padding(.bottom, -5)
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Today")
                        .foregroundColor(.white)
                        .font(Font.system(size: 14))
                        .fontWeight(.medium)
                        .shadow(color: .gray.opacity(0.2), radius: 1.0)
                        .opacity(0.5)
                    
                    Text("Average")
                        .foregroundColor(.white)
                        .font(Font.system(size: 14))
                        .fontWeight(.medium)
                        .shadow(color: .gray.opacity(0.2), radius: 1.0)
                        .opacity(0.5)
                }
                
                Spacer()
                
                VStack {
                    Text("H:2º")
                        .foregroundColor(.white)
                        .font(Font.system(size: 16))
                        .fontWeight(.bold)
                        .shadow(color: .gray.opacity(0.2), radius: 1.0)
                    
                    Text("H:4º")
                        .foregroundColor(.white)
                        .font(Font.system(size: 16))
                        .fontWeight(.bold)
                        .shadow(color: .gray.opacity(0.2), radius: 1.0)
                }
            }
        }
        .padding(15.0)
        .background(RoundedRectangle(cornerRadius: 20).fill(.secondary.opacity(0.2)))
        .cornerRadius(15)
    }
}

#Preview {
    AveragesView()
}

