//
//  PrecipitationView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 03.12.2024.
//

import SwiftUI

struct PrecipitationView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 4) {
                Image(systemName: "drop.fill")
                    .font(Font.system(size: 13))
                    .foregroundColor(.white)
                    .shadow(color: .gray.opacity(0.2), radius: 1.0)
                    .opacity(0.5)
                
                Text("Precipitation".uppercased())
                    .font(Font.system(size: 13))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .shadow(color: .gray.opacity(0.2), radius: 1.0)
                    .opacity(0.5)
            }
            .padding(.top, -5)
            .padding(.bottom, 10)
            
            Text("3 mm")
                .foregroundColor(.white)
                .font(Font.system(size: 32))
                .fontWeight(.medium)
                .shadow(color: .gray.opacity(0.2), radius: 1.0)
                .padding(.bottom, -5)
            
            Text("in last 24h")
                .foregroundColor(.white)
                .font(Font.system(size: 20))
                .fontWeight(.medium)
                .shadow(color: .gray.opacity(0.2), radius: 1.0)
                .padding(.bottom, -5)
            
            Spacer()
            
            HStack {
                Text("Next expected is 3 mm rain on Thu.")
                    .foregroundColor(.white)
                    .font(Font.system(size: 14))
                    .fontWeight(.medium)
                    .shadow(color: .gray.opacity(0.2), radius: 1.0)
                
                Spacer()
            }
        }
        .padding(15.0)
        .background(RoundedRectangle(cornerRadius: 20).fill(.secondary.opacity(0.2)))
        .cornerRadius(15)
    }
}

#Preview {
    PrecipitationView()
}

