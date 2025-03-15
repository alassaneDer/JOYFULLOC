//
//  ColorTesteurAccessibility.swift
//  JoyFullOC
//
//  Created by Alassane Der on 13/03/2025.
//

/// this view isn't used in this app, just to make sure that accessibility Colors work well

import SwiftUI

struct ColorTesteurAccessibility: View {
    
    @Environment(\.self) private var env
    
    var body: some View {
        ZStack {
            Color.accessibleBackground(env)
                .ignoresSafeArea()
            
            Text("Bonjour !")
                .foregroundColor(Color.accessiblePrimaryAccent(env))
                .padding()
        }
    }
}

#Preview {
    ColorTesteurAccessibility()
}
