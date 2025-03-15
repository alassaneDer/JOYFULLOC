//
//  CoreDataClothing+ClothingStoreProtocol.swift
//  JoyFullOC
//
//  Created by Alassane Der on 15/03/2025.
//

import CoreData

extension CoreDataClothing: ClothingStoreProtocol {
    
    func updateLikes(for itemId: Int, newLikes: Int) throws {
        guard let managedClothing = try ManagedClothing.find(by: itemId, in: context) else {
            throw NSError(domain: "UpdateError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Item not found"])
        }
        
        managedClothing.likes = Int64(newLikes)
    }
    func updateComment(for itemId: Int, newComment: String) throws {
        guard let managedClothing = try ManagedClothing.find(by: itemId, in: context) else {
            throw NSError(domain: "UpdateError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Item not found"])
        }
        
        managedClothing.userComment = newComment
    }
    func updateRating(for itemId: Int, newRating: Double) throws {
        guard let managedClothing = try ManagedClothing.find(by: itemId, in: context) else {
            throw NSError(domain: "UpdateError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Item not found"])
        }
        
        managedClothing.userRating = newRating
    }
    
    func retrieveAll() throws -> [ClothingItem] {
        //        let managedItems = try ManagedClothing.findAll(in: context)
        //        return managedItems.map { $0.toDomain() }
        let managedItems = try ManagedClothing.findAll(in: self.context)
        print("🛑 \(managedItems.count) objets Core Data trouvés")
        
        let items = managedItems.map { item in
            let domainItem = item.toDomain()
            print("🔄 Conversion toDomain() : \(domainItem)")
            return domainItem
        }
        
        print("✅ Fin de loadFromCoreData - \(items.count) objets convertis")
        return managedItems.map { $0.toDomain() }   /// à enlever

    }
    /// voir si utile pour récupérer l'item apres update
    func retrieve(_ clothingItem: ClothingItem) throws -> ClothingItem? {
        guard let managedItems = try ManagedClothing.find(by: clothingItem.id, in: context) else {
            throw NSError(domain: "UpdateError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Item not found"])
        }
        return managedItems.toDomain()
    }
    
    func update(_ clothingItem: ClothingItem) throws {
        guard let managedItem = try ManagedClothing.find(by: clothingItem.id, in: context) else {
            throw NSError(domain: "UpdateError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Item not found"])
        }
        managedItem.likes = Int64(clothingItem.likes)
        managedItem.userComment = clothingItem.userComment
        managedItem.userRating = clothingItem.userRating
        managedItem.isLiked = clothingItem.isLiked
        
        try context.save()
        //        try ManagedClothing.find(by: clothingItem.id, in: context)
        //        try self.retrieve(clothingItem)
    }
    
    func insertAll(_ clothingItems: [ClothingItem]) throws {
        let context = self.context
        context.performAndWait {
//            let newItems  = clothingItems.filter { ManagedClothing.itemExists(by: Int64($0.id), in: context)}   /// sert à éviter les doublons
            let newItems = clothingItems.filter { !ManagedClothing.itemExists(by: Int64($0.id), in: context) }
            newItems.forEach { item in
                _ = ManagedClothing.fromDomain(item, context: context)
            }
            do {
                try context.save()
            } catch let error as NSError {
                print("erreur lors du chargement des données.\(error), \(error.userInfo)")
            }
        }
    }
    
    /// sert à supprimer les doublons
    func removeDuplicates() throws {
        let items = try ManagedClothing.findAll(in: context)
        var uniqueItems = [Int64: ManagedClothing]()
        
        for item in items {
            if let _ = uniqueItems[item.id] {
                context.delete(item) /// Supprime les doublons
            } else {
                uniqueItems[item.id] = item
            }
        }
        
        try context.save()
    }
}
