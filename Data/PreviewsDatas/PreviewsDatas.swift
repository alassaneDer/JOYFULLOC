//
//  PreviewsDatas.swift
//  JoyFullOC
//
//  Created by Alassane Der on 12/03/2025.
//

import Foundation

final class PreviewsDatas: DataProvider {

    func FetchItems() async -> [ClothingItem] {
        return clothes
    }
    
    func fetch(_ clothingItem: ClothingItem) async -> ClothingItem? {
        //
        return clothingItem
    }
    
    func update(_ clothingItem: ClothingItem) async {
        if let index = clothes.firstIndex(where: {$0.id == clothingItem.id}) {
            clothes[index] = clothingItem
        }
    }
    

    var clothes: [ClothingItem] = [
    ClothingItem(
        id: 1,
        picture:
            PictureItem(
                url: "https://picsum.photos/id/1/200/300",
                description: "Pull vert forêt à motif torsadé élégant, tricot finement travaillé avec manches bouffantes et col montant; doux et chaleureux."
            ),
        name: "Premier article",
        likes: 56,
        price: 69.99,
        originalPrice: 79.99,
        category: .accessoires
    ),
    ClothingItem(
        id: 2,
        picture:
            PictureItem(
                url: "https://picsum.photos/id/2/200/300",
                description: "description du premier faux article pour la preview"
            ),
        name: "Second article",
        likes: 56,
        price: 69.99,
        originalPrice: 69.99,
        category: .accessoires
    ),
    ClothingItem(
        id: 3,
        picture:
            PictureItem(
                url: "https://picsum.photos/id/3/200/300",
                description: "description du premier faux article pour la preview"
            ),
        name: "Troisième article",
        likes: 56,
        price: 69.99,
        originalPrice: 69.99,
        category: .accessoires
    ),
    ClothingItem(
        id: 4,
        picture:
            PictureItem(
                url: "https://picsum.photos/id/4/200/300",
                description: "description du quatrième faux article pour la preview"
            ),
        name: "Quatrième article",
        likes: 36,
        price: 49.99,
        originalPrice: 69.99,
        category: .tops
    ),
    ClothingItem(
        id: 5,
        picture:
            PictureItem(
                url: "https://picsum.photos/id/5/200/300",
                description: "description du quatrième faux article pour la preview"
            ),
        name: "quatrième article",
        likes: 36,
        price: 49.99,
        originalPrice: 69.99,
        category: .tops
    ),
    ClothingItem(
        id: 6,
        picture:
            PictureItem(
                url: "https://picsum.photos/id/6/200/300",
                description: "description du quatrième faux article pour la preview"
            ),
        name: "quatrième article",
        likes: 36,
        price: 49.99,
        originalPrice: 69.99,
        category: .tops
    ),
    ClothingItem(
        id: 7,
        picture:
            PictureItem(
                url: "https://picsum.photos/id/7/200/300",
                description: "description du quatrième faux article pour la preview"
            ),
        name: "quatrième article",
        likes: 36,
        price: 49.99,
        originalPrice: 69.99,
        category: .tops
    ),
    ClothingItem(
        id: 8,
        picture:
            PictureItem(
                url: "https://picsum.photos/id/8/200/300",
                description: "description du second faux article pour la preview"
            ),
        name: "second article",
        likes: 46,
        price: 59.99,
        originalPrice: 69.99,
        category: .bottoms
    ),
    ClothingItem(
        id: 9,
        picture:
            PictureItem(
                url: "https://picsum.photos/id/9/200/300",
                description: "description du second faux article pour la preview"
            ),
        name: "second article",
        likes: 46,
        price: 59.99,
        originalPrice: 69.99,
        category: .bottoms
    ),
    ClothingItem(
        id: 10,
        picture:
            PictureItem(
                url: "https://picsum.photos/id/10/200/300",
                description: "description du second faux article pour la preview"
            ),
        name: "second article",
        likes: 46,
        price: 59.99,
        originalPrice: 69.99,
        category: .bottoms
    ),
    ClothingItem(
        id: 11,
        picture:
            PictureItem(
                url: "https://picsum.photos/id/11/200/300",
                description: "description du troisième faux article pour la preview"
            ),
        name: "troisième article",
        likes: 66,
        price: 79.99,
        originalPrice: 69.99,
        category: .shoes
    ),
    ClothingItem(
        id: 12,
        picture:
            PictureItem(
                url: "https://picsum.photos/id/12/200/300",
                description: "description du troisième faux article pour la preview"
            ),
        name: "troisième article",
        likes: 66,
        price: 79.99,
        originalPrice: 69.99,
        category: .shoes
    ),
    ClothingItem(
        id: 13,
        picture:
            PictureItem(
                url: "https://picsum.photos/id/13/200/300",
                description: "description du troisième faux article pour la preview"
            ),
        name: "troisième article",
        likes: 66,
        price: 79.99,
        originalPrice: 69.99,
        category: .shoes
    )
]
    
}
