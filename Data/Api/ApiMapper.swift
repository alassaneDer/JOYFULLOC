//
//  ApiMapper.swift
//  JoyFullOC
//
//  Created by Alassane Der on 17/03/2025.
//

import Foundation

enum Mapper {
    
    private struct Root: Decodable {
        let id: Int
        let picture: Picture
        let name: String
        let category: String
        let likes: Int
        let price: Double
        let original_price: Double
        
        struct Picture: Decodable {
            let url: String
            let description: String
        }
        
        var item: ClothingItem {
            ClothingItem(
                id: id,
                picture: PictureItem(url: picture.url, description: picture.description),
                name: name,
                likes: likes,
                price: price,
                originalPrice: original_price,
                category: ClothingItem.Category(rawValue: category) ?? .others
            )
        }
    }
    
    enum Error: Swift.Error {
        case invalidResponseStatusCode
        case decodingResponseFailed
    }
    
    static func map(_ data: Data, and response: HTTPURLResponse) throws -> [ClothingItem] {
        guard response.statusCode == 200 else {
            throw Error.invalidResponseStatusCode
        }
        
        do {
            let root = try JSONDecoder().decode([Root].self, from: data)
            let items = root.map { $0.item }
            return items
        } catch {
            throw Error.decodingResponseFailed
        }
    }
}
