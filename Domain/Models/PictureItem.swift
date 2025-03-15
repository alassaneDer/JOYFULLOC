//
//  PictureItem.swift
//  JoyFullOC
//
//  Created by Alassane Der on 12/03/2025.
//

import Foundation

struct PictureItem : Hashable, Codable, Identifiable {
    var id: UUID = UUID()
    var url: String
    var description: String
}
