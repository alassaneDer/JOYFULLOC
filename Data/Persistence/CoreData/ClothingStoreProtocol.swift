//
//  ClothingStoreProtocol.swift
//  JoyFullOC
//
//  Created by Alassane Der on 15/03/2025.
//

import Foundation

protocol ClothingStoreProtocol {
    func retrieveAll() throws -> [ClothingItem]
    func retrieve(_ clothingItem: ClothingItem) throws -> ClothingItem?
    func update(_ clothingItem: ClothingItem) throws
    func updateLikes(for itemId: Int, newLikes: Int) throws
    func updateComment(for itemId: Int, newComment: String) throws
    func updateRating(for itemId: Int, newRating: Double) throws
    func insertAll(_ clothingItems: [ClothingItem]) throws
    func removeDuplicates() throws
}
