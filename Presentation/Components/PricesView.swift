//
//  PricesView.swift
//  JoyFullOC
//
//  Created by Alassane Der on 13/03/2025.
//

import SwiftUI


struct PricesView: View {
    
    @Environment(\.self) private var env
    
    var clothingItem: ClothingItem = PreviewsDatas().clothes[0]
    var isSelected: Bool = true
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .firstTextBaseline) {
                Text("\(clothingItem.name)")
                    .fontWeight(.bold).font(.headline)
                    .minimumScaleFactor(0.6) /// Évite que le texte ne soit tronqu
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                
                Spacer()
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundStyle(Color.orange)
                    Text("0.0")
                        .baselineOffset(2.0)
                }
                
            }
            HStack(spacing: 0) {
                Text("\(clothingItem.price, specifier: "%.0f")€")
                Spacer()
                Text("\(clothingItem.originalPrice, specifier: "%.0f")€")
                    .foregroundStyle(isSelected ? Color.accessiblePrimaryAccent(env) : Color.primary.opacity(0.6))
                    .strikethrough()
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(clothingItem.name), \(clothingItem.price, specifier: "%.0f")€")
        .foregroundStyle(isSelected ? Color.accessiblePrimaryAccent(env) : .primary)
    }
}


#Preview {
    PricesView()
}
