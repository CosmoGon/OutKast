//
//  MapView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 28.11.2024.
//

import SwiftUI

struct MapView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            MapContent()
            
            HStack(alignment: .top) {
                VStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                            .frame(width: 60, height: 40)
                            .foregroundColor(.white)
                            .background(Color.gray, in: RoundedRectangle(cornerRadius: 10))
                    }
                    .padding()
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    MapView()
}
