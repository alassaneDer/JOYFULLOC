//
//  ClothingItem.swift
//  JoyFullOC
//
//  Created by Alassane Der on 12/03/2025.
//

import Foundation

struct ClothingItem: Hashable, Codable, Identifiable {
    var id: Int
    var picture: PictureItem
    var name: String
    var likes: Int
    var price: Double
    var originalPrice: Double
    
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case accessoires = "ACCESSORIES"
        case bottoms = "BOTTOMS"
        case tops = "TOPS"
        case shoes = "SHOES"
        case others = "OTHERS"
    }
    
    /// user comments and ratings
    var userComment: String? = ""
    var userRating: Double = 0.0
    var isLiked: Bool = false
}
