//
//  SharedButton.swift
//  JoyFullOC
//
//  Created by Alassane Der on 15/03/2025.
//

import SwiftUI

struct SharedButton: View {
    var isSharing: Bool = false
    
    var body: some View {
        
        VStack(spacing: 10) {

                Image("iconShare")
                    .padding()
                    .background(Color.gray.opacity(0.5))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            if isSharing {
                HStack(spacing: 15) {
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                    
                    Image(systemName: "heart.fill")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    
                    Image(systemName: "bolt.fill")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                }
                .transition(.scale) // Effet d'animation sympa
            }
        }
}

#Preview {
    SharedButton()
}
