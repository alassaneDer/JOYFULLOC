//
//  ContentView.swift
//  JoyFullOC
//
//  Created by Alassane Der on 11/03/2025.
//

import SwiftUI

struct ItemView: View {
    
    @Environment(\.self) private var env
    var clothingItem: ClothingItem = PreviewsDatas().clothes[0]
    var isSelected: Bool = false
    
    var action: (ClothingItem) -> Void = {_ in }
        
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var body: some View {
        VStack(spacing: nil) {
            HStack (alignment: .top) {
                VStack (spacing: 8){
                    AsyncImage(url: URL(string: clothingItem.picture.url)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: DynamicTypeSize.imageWidth(for: dynamicTypeSize))
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                .overlay {
                                    if isSelected {
                                        RoundedRectangle(cornerRadius: 20.0)
                                            .stroke(Color.accessiblePrimaryAccent(env), lineWidth: 3)
                                    }
                                }
                                .accessibilityLabel(clothingItem.name)
                                .accessibilityHint("Image du vêtement.")
                                .accessibilityAddTraits(.isImage)

                        case .failure:
                            Image(systemName: "exclamationmark.triangle")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .accessibilityLabel("Image indisponible")
                        default:
                            ProgressView()
                        }
                    }
                    .overlay(alignment: .bottomTrailing) {
                        ButtonLikes(action: action, clothingItem: clothingItem)
                    }
                    
                    PricesView(clothingItem: clothingItem, isSelected: isSelected)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.top, 4)
                        .frame(height: DynamicTypeSize.priceCellHeight(for: dynamicTypeSize))
                }
            }
        }
        .frame(width: DynamicTypeSize.imageWidth(for: dynamicTypeSize))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(clothingItem.name), avec \(clothingItem.likes) mentions j'aime.")
        .accessibilityValue(isSelected ? "Sélectionné" : "Non sélectionné")
        .accessibilityHint("Double-tapez pour sélectionner et voir les détails de cet article.")
        .accessibilityAddTraits(.isButton)
    }
}

#Preview {
    ItemView()
}
