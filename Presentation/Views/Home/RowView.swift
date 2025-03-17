//
//  RowView.swift
//  JoyFullOC
//
//  Created by Alassane Der on 13/03/2025.
//

import SwiftUI

struct RowView: View {
    @StateObject var homeViewmodel: HomeViewModel
    
    var items: [ClothingItem]
    @StateObject private var orientationManager = DeviceOrientationManager()
    var categoryName: String = "Bas"
    var action: (ClothingItem) -> Void = {_ in }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                Text(categoryName)
                    .font(.title)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(items) { clothing in
                            if orientationManager.isLandscapeOnIpad {
                                ItemView(
                                    clothingItem: clothing,
                                    isSelected: clothing == homeViewmodel.selectedItem,
                                    action: { item in
                                        Task {
                                            await homeViewmodel.updateLikes(item)
                                        }
                                    }
                                )
                                .onTapGesture {
                                    homeViewmodel.selectClothing(clothing)
                                }
                                .accessibilityHint("Double-tappez pour voir les détails")
                            } else {
                                VStack {
                                    NavigationLink {
                                        DetailView(homeViewmodel: homeViewmodel, clothingItem: clothing)
                                    } label: {
                                        ItemView(clothingItem: clothing,
                                                 action: { item in
                                            Task {
                                                await homeViewmodel.updateLikes(item)
                                            }
                                        })
                                        .foregroundStyle(Color.primary)
                                        .accessibilityHint("Double-tappez pour voir les détails")
                                    }
                                }
                            }
                        }
                    }
                }
                .accessibilityHint("Faites défiler horizontalement pour voir plus d'articles.")
            }
            .padding(.leading, 8)
        }
        .onAppear {
            Task {
                await homeViewmodel.loadClothingItems()
            }
        }
        .accessibilityElement(children: .contain)
    }
}

#Preview {
    RowView(homeViewmodel: HomeViewModel(dataProvider: PreviewsDatas()), items: HomeViewModel(dataProvider: PreviewsDatas()).clothes)
}
