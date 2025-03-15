//
//  ButtonLikes.swift
//  JoyFullOC
//
//  Created by Alassane Der on 13/03/2025.
//

import SwiftUI

struct ButtonLikes: View {
    @Environment(\.self) private var env
    
    var action: (ClothingItem) -> Void = {_ in }
    var clothingItem: ClothingItem = PreviewsDatas().clothes[0]
    
    var body: some View {
        HStack {
            Image(systemName: clothingItem.isLiked ? "heart.fill" : "heart")
            Text("\(clothingItem.likes)")
        }
        .padding(8)
        .background(Color.accessibleBackground(env))
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
        .padding()
        .onTapGesture {
            action(clothingItem)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(clothingItem.likes) likes")
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(clothingItem.isLiked ? "liked" : "not liked")
        .accessibilityHint(clothingItem.isLiked ? "Double-tap to remove from likes." : "Double-tap to like this item.")
    }
}

#Preview {
    ButtonLikes()
}
