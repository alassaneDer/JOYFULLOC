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
            
            Image("icons8-share-30")
                .renderingMode(.template)
                .padding()
                .background(Color.gray.opacity(0.5))
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        
        if isSharing {
            HStack(spacing: 15) {
                Image(systemName: "f.circle.fill")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.blue.opacity(0.5))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Image(systemName: "envelope.circle.fill")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.gray.opacity(0.5))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .transition(.scale)
        }
    }
}

#Preview {
    SharedButton()
}
