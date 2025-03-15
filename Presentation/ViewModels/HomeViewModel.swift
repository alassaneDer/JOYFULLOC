//
//  HomeViewModel.swift
//  JoyFullOC
//
//  Created by Alassane Der on 13/03/2025.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var clothes: [ClothingItem] = []
    @Published var selectedItem: ClothingItem? = nil
    @Published var isSelectingItem: Bool = false
    @Published var userRating: Double = 0.0
    
    private let dataProvider: DataProvider
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    var categories: [String : [ClothingItem]] {
        Dictionary(
            grouping: clothes
        ) { item in
            toFrenchCategory(from: item.category.rawValue)
        }
    }
    
    private func toFrenchCategory(from englishCategory: String) -> String {
        switch englishCategory {
        case "ACCESSORIES":
            return "Accessoires"
        case "BOTTOMS":
            return "Bas"
        case "TOPS":
            return "Hauts"
        default:
            return englishCategory.lowercased()
        }
    }
    
    func selectClothing(_ clothing: ClothingItem) {
        if selectedItem == clothing {
            selectedItem = nil
            isSelectingItem = false
        } else {
            selectedItem = clothing
            isSelectingItem = true
        }
    }
    
    func loadClothingItems() async {
        do {
            clothes = try await dataProvider.FetchItems()
        } catch {
            print("From VM Erreurs lors du chargement des articles : \(error.localizedDescription)")
        }
    }
    
    func updateLikes(_ clothingItem: ClothingItem) async {
        var updatedItem = clothingItem
        updatedItem.isLiked.toggle()
        
        if updatedItem.isLiked {
            updatedItem.likes += 1
        } else {
            updatedItem.likes -= 1
        }
        
        do {
            try await dataProvider.update(updatedItem)
            Task {
                await loadClothingItems()
            }
            self.selectedItem = try await dataProvider.fetch(updatedItem)
            print("updated")
        } catch {
            print("Erreurs lors de la mise à jour des likes : \(error)")
        }
    }
    
    func updateRatings(_ clothingItem: ClothingItem, newUserRating: Double) async {
        var updatedClothing = clothingItem
        userRating = newUserRating
        updatedClothing.userRating = newUserRating
        do {
            print("Before update:", updatedClothing)
            try await dataProvider.update(updatedClothing)
            print("After update:", updatedClothing)
            Task {
                await loadClothingItems()
            }
            self.selectedItem = try await dataProvider.fetch(updatedClothing)
        } catch {
            print("Failed to update userRating")
        }
    }
}
