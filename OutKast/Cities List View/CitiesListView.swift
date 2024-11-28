//
//  CitiesListView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 28.11.2024.
//

import SwiftUI

struct CitiesListView: View {
    @Environment(\.dismiss) private var dismiss
    let currentLocation: City?
    @Binding var selectedCity: City?
    
    var body: some View {
        NavigationStack {
            List {
                if let currentLocation {
                    Text(currentLocation.name)
                        .onTapGesture {
                            selectedCity = currentLocation
                            dismiss()
                        }
                }
                
                ForEach(City.cities) { city in
                    Text(city.name)
                        .onTapGesture {
                            selectedCity = city
                            dismiss()
                        }
                }
            }
            .listStyle(.plain)
            .navigationTitle("My Cities")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    CitiesListView(currentLocation: City.mockCurrent, selectedCity: .constant(nil))
}
