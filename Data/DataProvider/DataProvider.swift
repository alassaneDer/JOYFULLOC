//
//  DataProvider.swift
//  JoyFullOC
//
//  Created by Alassane Der on 12/03/2025.
//

import Foundation

protocol DataProvider {
    func FetchItems() async throws -> [ClothingItem]
    func fetch(_ clothingItem: ClothingItem) async throws -> ClothingItem?
    func update(_ clothingItem: ClothingItem) async throws
}
