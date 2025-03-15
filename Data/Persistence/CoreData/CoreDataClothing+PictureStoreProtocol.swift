//
//  CoreDataClothing+PictureStoreProtocol.swift
//  JoyFullOC
//
//  Created by Alassane Der on 15/03/2025.
//

import CoreData

extension CoreDataClothing: PictureStoreProtocol {
    func fetchPicture(by id: UUID) throws -> PictureItem? {
        let managedPicture = try ManagedPicture.find(by: id, in: context)
        return managedPicture?.toDomain()
    }
    
    func savePicture(_ picture: PictureItem) throws {
        let _ = ManagedPicture.fromDomain(picture, context: context)
        try context.save()
    }
}
