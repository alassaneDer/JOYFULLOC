//
//  File.swift
//  JoyFullOC
//
//  Created by Alassane Der on 14/03/2025.
//

import Foundation
import SwiftUI

class DeviceOrientationManager: ObservableObject {
    @Published var isLandscapeOnIpad: Bool = false
        
    init() {
        updateOrientation() // Mettre à jour immédiatement
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc private func orientationChanged() {
        updateOrientation()
    }
    
    private func updateOrientation() {
        let device = UIDevice.current
        let isLandscape = device.orientation.isLandscape
        let isIpad = UIDevice.current.userInterfaceIdiom == .pad
        
        /// Met à jour la variable observée
        DispatchQueue.main.async {
            self.isLandscapeOnIpad = isIpad && isLandscape
        }
    }
}
