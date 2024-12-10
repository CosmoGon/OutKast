//
//  CitiesListView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 28.11.2024.
//

import SwiftUI
import WeatherKit

struct CitiesListView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(DataStore.self) private var store

    let currentLocation: City?
    @Binding var selectedCity: City?
    @State private var isSearching = false
    @State private var temperatureUnit: TemperatureUnit = .celsius
    @State private var isUnitsPresented = false
    @FocusState private var isFocused: Bool

    enum TemperatureUnit: String, CaseIterable {
        case celsius = "Celsius"
        case fahrenheit = "Fahrenheit"
    }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")

                        TextField("Search for a city or airport", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                            .focused($isFocused)
                    }
                    .padding()
                    .onTapGesture {
                        withAnimation {
                            isSearching.toggle()
                        }
                    }

                    // Cities List
                    List {
                        Group {
                            if let currentLocation {
                                CityRowView(city: currentLocation)
                                    .onTapGesture {
                                        selectedCity = currentLocation
                                        dismiss()
                                    }
                            }

                            ForEach(store.cities) { city in
                                CityRowView(city: city)
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            if let index = store.cities.firstIndex(where: { $0.id == city.id }) {
                                                store.cities.remove(at: index)
                                                store.saveCities()
                                            }
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                    }
                                    .onTapGesture {
                                        selectedCity = city
                                        dismiss()
                                    }
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .listRowInsets(.init(top: 0, leading: 20, bottom: 10, trailing: 20))
                        .padding(.vertical, 3)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .navigationTitle("Weather")
                    .preferredColorScheme(.dark)
                    .navigationBarItems(
                        trailing: Menu {
                            Picker("Temperature unit", selection: $temperatureUnit) {
                                ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                                    Label(unit.rawValue, systemImage: unit == .celsius ? "c.circle" : "f.circle")
                                }
                            }

                            Button(action: {
                                isUnitsPresented.toggle()
                            }) {
                                Label("Units", systemImage: "chart.bar")
                            }

                            Divider()

                            Button(action: {
                                // Handle action for the menu item
                            }) {
                                Label("Report an Issue", systemImage: "exclamationmark.bubble")
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                        }
                    )
                }

                // Search Overlay
                if isSearching {
                    SearchOverlay(isSearching: $isSearching)
                        .zIndex(1)
                }
            }
        }
    }
}

#Preview {
    CitiesListView(currentLocation: City.mockCurrent, selectedCity: .constant(nil))
        .environment(LocationManager())
        .environment(DataStore(forPreviews: true))
}
