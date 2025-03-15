//
//  TestDeviceOrientationView.swift
//  JoyFullOC
//
//  Created by Alassane Der on 14/03/2025.
//

import SwiftUI

struct TestDeviceOrientationView: View {
    @StateObject private var orientationManager = DeviceOrientationManager()
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    if orientationManager.isLandscapeOnIpad {
                        Text("Code spécifique pour iPad en mode paysage")
                            .font(.title)
                            .foregroundColor(.blue)
                    } else {
                        Text("Code pour les autres appareils et orientations")
                            .font(.title)
                            .foregroundColor(.green)
                    }
                }
                .padding()
            }
            .navigationTitle("home")
        }
    }
}


#Preview {
    TestDeviceOrientationView()
}
