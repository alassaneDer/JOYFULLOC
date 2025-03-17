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
        .onTapGesture {
            action(clothingItem)
        }
        .padding(8)
        .background(Color.accessibleBackground(env))
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
        .padding()
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("article avec \(clothingItem.likes) mentions j'aime")
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(clothingItem.isLiked ? "article favori" : "article non favori")
        .accessibilityHint(clothingItem.isLiked ? "Tapper pour enlever l'article de vos favorits." : "Tapper pour mettre l'article en favorit")
    }
}

#Preview {
    ButtonLikes()
}
