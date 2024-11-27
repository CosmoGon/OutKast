//
//  LocationDeniedView.swift
//  OutKast
//
//  Created by Cosmin Ghinea on 27.11.2024.
//

import SwiftUI

struct LocationDeniedView: View {
    var body: some View {
        ContentUnavailableView(label: {
            Label("Location Services", systemImage: "gear")
        },
                               description: {
            Text("""
1. Tap on the button below to go to "Privacy and Security"
2. Tap on "Location Services"
3. Locate the "OutKast" app and tap on it
4. Change the setting to "While Using the App"
"""
            ).multilineTextAlignment(.center)
        }, actions: {
            Button {
                UIApplication.shared.open(
                    URL(string: UIApplication.openSettingsURLString)!,
                    options: [:],
                    completionHandler: nil
                )
            } label: {
                Text("Open Settings")
            }
            .buttonStyle(.borderedProminent)
        })
    }
}

#Preview {
    LocationDeniedView()
}
