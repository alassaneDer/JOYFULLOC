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
        var imageHeight: CGFloat {
            switch dynamicTypeSize {
            case .xSmall, .small:
                return 90 // Taille normale
            case .medium:
                return 120
            case .large:
                return 150 // Réduit légèrement
            case .xLarge:
                return 180 // Réduit plus
            case .xxLarge, .xxxLarge:
                return 210 // Encore plus petit pour laisser la place au texte
            case .accessibility1, .accessibility2, .accessibility3, .accessibility4, .accessibility5:
                return 240 // Taille minimale pour l’accessibilité maximale
            @unknown default:
                return 180 // Valeur par défaut si Apple ajoute de nouvelles tailles
            }
        }
         var imageWidth: CGFloat {
            switch dynamicTypeSize {
            case .xSmall, .small:
                return 170 // Taille normale
            case .medium:
                return 180
            case .large:
                return 140 // Réduit légèrement
            case .xLarge:
                return 210 // Réduit plus
            case .xxLarge, .xxxLarge:
                return 220 // Encore plus petit pour laisser la place au texte
            case .accessibility1, .accessibility2, .accessibility3, .accessibility4, .accessibility5:
                return 230 // Taille minimale pour l’accessibilité maximale
            @unknown default:
                return 320 // Valeur par défaut si Apple ajoute de nouvelles tailles
            }
        }

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
                                .frame(width: imageWidth)
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
                        .frame(height: 80)
                }
            }
        }
        .frame(width: imageHeight)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(clothingItem.name), \(clothingItem.likes) likes.")
        .accessibilityValue(isSelected ? "Sélectionné" : "Non sélectionné")
        .accessibilityHint("Double-tapez pour sélectionner cet article.")
        .accessibilityAddTraits(.isButton)
    }
}


//struct ItemView: View {
//    
//    @Environment(\.self) private var env
//    var clothingItem: ClothingItem = PreviewsDatas().clothes[0]
//    var isSelected: Bool = false
//    
//    var action: (ClothingItem) -> Void = {_ in }
//    
//    @Environment(\.dynamicTypeSize) var dynamicTypeSize
//    var imageHeight: CGFloat {
//        switch dynamicTypeSize {
//        case .xSmall, .small:
//            return 90 // Taille normale
//        case .medium:
//            return 120
//        case .large:
//            return 150 // Réduit légèrement
//        case .xLarge:
//            return 180 // Réduit plus
//        case .xxLarge, .xxxLarge:
//            return 210 // Encore plus petit pour laisser la place au texte
//        case .accessibility1, .accessibility2, .accessibility3, .accessibility4, .accessibility5:
//            return 240 // Taille minimale pour l’accessibilité maximale
//        @unknown default:
//            return 180 // Valeur par défaut si Apple ajoute de nouvelles tailles
//        }
//    }
//     var imageWidth: CGFloat {
//        switch dynamicTypeSize {
//        case .xSmall, .small:
//            return 170 // Taille normale
//        case .medium:
//            return 180
//        case .large:
//            return 140 // Réduit légèrement
//        case .xLarge:
//            return 210 // Réduit plus
//        case .xxLarge, .xxxLarge:
//            return 220 // Encore plus petit pour laisser la place au texte
//        case .accessibility1, .accessibility2, .accessibility3, .accessibility4, .accessibility5:
//            return 230 // Taille minimale pour l’accessibilité maximale
//        @unknown default:
//            return 320 // Valeur par défaut si Apple ajoute de nouvelles tailles
//        }
//    }
//    
//    var body: some View {
//        
//        VStack(spacing: nil) {    /// image + overlay  de selection + prices
//            HStack (alignment: .top) {
//                VStack (spacing: 8){
//                    AsyncImage(url: URL(string: clothingItem.picture.url)) { phase in
//                        switch phase {
//                        case .success(let image):
//                            image
//                                .resizable()
////                                .scaledToFit()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: imageWidth/*, height: imageHeight*/)
//                                .clipped()
//                                .clipShape(RoundedRectangle(cornerRadius: 20.0))
//                                .overlay {
//                                    if isSelected {
//                                        RoundedRectangle(
//                                            cornerRadius: 20.0
//                                        ).stroke(
//                                            Color.accessiblePrimaryAccent(env),
//                                            lineWidth: 3
//                                        )
//                                    }
//                                }
//                        case .failure:
//                            Image(systemName: "exclamationmark.triangle")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(maxWidth: .infinity)
//                        default:
//                            ProgressView()
//                        }
//                    }
//                    .overlay(alignment: .bottomTrailing) {
//                        ButtonLikes(action: action, clothingItem: clothingItem)
//                    }
//                    
//                    /// prices
//                    PricesView(clothingItem: clothingItem, isSelected: isSelected)
//                        .multilineTextAlignment(.leading)
//                        .lineLimit(nil)
////                        .font(.body)
////                        .lineLimit(2)
////                        .minimumScaleFactor(0.8) /// Évite que le texte ne soit tronqué
//                        .padding(.top, 4) /// Laisse de l’espace sous l’image
//                        .frame(height: 80)
//                }
//            }
//        }
//        .frame(width: imageHeight)
//        .accessibilityElement(children: .combine)
//        .accessibilityLabel("\(clothingItem.name), \(clothingItem.likes) likes.")
//        .accessibilityValue(isSelected ? "Selected" : "Not selected")
//        .accessibilityHint("Double-tap to select this item.")
//        .accessibilityAddTraits(.isButton)
//    }
//}

#Preview {
    ItemView()
}

///
//            HStack {
//                AsyncImage(url: URL(string: clothingItem.picture.url)) { phase in
//                    switch phase {
//                    case .success(let image):
//                        image
//                            .resizable()
//                            .scaledToFill()
//                            .frame(maxWidth: .infinity/*, maxHeight: imageHeight*/)
//                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
//                    case .failure:
//                        Image(systemName: "exclamationmark.triangle")
//                            .foregroundStyle(Color.red)
//                    default:
//                        ProgressView()
//                    }
//                }
//                .overlay {
//                    if isSelected {
//                        RoundedRectangle(
//                            cornerRadius: 20.0
//                        ).stroke(
//                            Color.accessiblePrimaryAccent(env),
//                            lineWidth: 3
//                        )
//                    }
//                }
//            }




//Text(clothingItem.name)
//    .font(.body)
//    .lineLimit(2)
//    .minimumScaleFactor(0.8) // Évite que le texte ne soit tronqué
//    .padding(.top, 8) // Laisse de l’espace sous l’image



//        GeometryReader(content: { geometry in
//            VStack {
//                VStack(spacing: nil) {
//
//
//
//                        .overlay(alignment: .bottomTrailing) {
//                            ButtonLikes()
//                        }
//
//                        PricesView(isSelected: isSelected)
//                            .font(.body)
//                            .lineLimit(2)
//                            .minimumScaleFactor(0.8) // Évite que le texte ne soit tronqué
//                            .padding(.top, 8) // Laisse de l’espace sous l’image
//
//                    }
//                    .frame(maxWidth: .infinity, minHeight: 250) // Permet à la cellule de grandir si nécessaire
//
//            }
//            .onTapGesture {
//                isSelected.toggle()
//            }
//
//        })
