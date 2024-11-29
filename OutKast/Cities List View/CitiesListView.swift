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
                Group {
                    if let currentLocation {
                        CityRowView(city: currentLocation)
                            .onTapGesture {
                                selectedCity = currentLocation
                                dismiss()
                            }
                    }
                    
                    ForEach(City.cities) { city in
                        CityRowView(city: city)
                            .onTapGesture {
                                selectedCity = city
                                dismiss()
                            }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .listRowInsets(.init(top: 0, leading: 20, bottom: 10, trailing: 20))
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
        .environment(LocationManager())
}
