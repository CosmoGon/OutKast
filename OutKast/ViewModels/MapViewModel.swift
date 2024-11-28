//
//  MapViewModel.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 28.11.2024.
//

import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 37.5485, longitude: -121.9886)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation,
                                               span: MapDetails.defaultSpan)
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async { [weak self] in
                    self?.locationManager = CLLocationManager()
                    self?.locationManager?.delegate = self
                }
            } else {
                print("Show an alert letting them know this is off and to go turn it on.")
            }
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied this app localization permission. Go into settings to change it.")
        case .authorizedAlways, .authorizedWhenInUse:
            DispatchQueue.main.async {
                    self.region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                                     span: MapDetails.defaultSpan)
                }
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

