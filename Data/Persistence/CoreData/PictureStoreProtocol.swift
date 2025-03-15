//
//  PictureStoreProtocol.swift
//  JoyFullOC
//
//  Created by Alassane Der on 15/03/2025.
//

import Foundation

protocol PictureStoreProtocol {
    func fetchPicture(by id: UUID) throws -> PictureItem?
    func savePicture(_ picture: PictureItem) throws
}
