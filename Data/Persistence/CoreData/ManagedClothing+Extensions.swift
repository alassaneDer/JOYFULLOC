//
//  ManagedClothing+Extensions.swift
//  JoyFullOC
//
//  Created by Alassane Der on 15/03/2025.
//

import CoreData

extension ManagedClothing {
    
    static func find(by id: Int, in context: NSManagedObjectContext) throws -> ManagedClothing? {
        let request = NSFetchRequest<ManagedClothing>(entityName: entity().name!)
        request.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        
        return try context.fetch(request).first
    }
    
    static func findAll(in context: NSManagedObjectContext) throws -> [ManagedClothing] {
//        let request = NSFetchRequest<ManagedClothing>(entityName: entity().name!)
//        request.returnsObjectsAsFaults = false
//        return try context.fetch(request)
            print("➡️ Début de findAll")
            
            let request = NSFetchRequest<ManagedClothing>(entityName: "ManagedClothing")
            request.returnsObjectsAsFaults = false
            
            let results = try context.fetch(request)
            print("✅ Fin de findAll - \(results.count) objets trouvés")
            
            return results
        

    }
    
    static func newInstance(context: NSManagedObjectContext) -> ManagedClothing {
        return ManagedClothing(context: context)
    }
    
//    static func itemExists(by id: Int64, in context: NSManagedObjectContext) -> Bool {
//        let request = NSFetchRequest<ManagedClothing>(entityName: entity().name!)
//        request.predicate = NSPredicate(format: "id == %lld", id as CVarArg)
//        request.returnsObjectsAsFaults = false
//        request.fetchLimit = 1
//        
//        let count = (try? context.count(for: request)) ?? 0
//        return count > 0
//    }
    static func itemExists(by id: Int64, in context: NSManagedObjectContext) -> Bool {
        guard let entityName = entity().name else {
            print("❌ ERREUR : Le nom de l'entité est nil !")
            return false
        }

        let request = NSFetchRequest<ManagedClothing>(entityName: entityName)
        request.predicate = NSPredicate(format: "id == %lld", id as CVarArg)
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1

        do {
            let count = try context.count(for: request)
            print("🔍 Vérification de l'existence de l'objet \(id) : \(count > 0)")
            return count > 0
        } catch {
            print("❌ ERREUR lors de la requête itemExists : \(error)")
            return false
        }
    }

    
    /// conversions
        /// i use these extensions to convert managedClothing from coredata to clothingItem
        /// and the second: for inverse : clothingItem to managedClothing
    func toDomain() -> ClothingItem {
        return ClothingItem(
            id: Int(id),
            picture: picture.toDomain(),
            name: name,
            likes: Int(likes),
            price: price,
            originalPrice: originalPrice,
            category: ClothingItem.Category(rawValue: category) ?? .others,
            
            userComment: userComment,
            userRating: userRating,
            isLiked: isLiked
        )
    }
    
    static func fromDomain(_ clothingItem: ClothingItem, context: NSManagedObjectContext) -> ManagedClothing {
        let managedClothing = ManagedClothing(context: context)
        managedClothing.id = Int64(clothingItem.id)
        managedClothing.name = clothingItem.name
        managedClothing.likes = Int64(clothingItem.likes)
        managedClothing.price = clothingItem.price
        managedClothing.originalPrice = clothingItem.originalPrice
        managedClothing.userComment = clothingItem.userComment ?? ""
        managedClothing.userRating = clothingItem.userRating
        managedClothing.isLiked = clothingItem.isLiked
        managedClothing.category = clothingItem.category.rawValue
        managedClothing.picture = ManagedPicture.fromDomain(clothingItem.picture, context: context)
        
        return managedClothing
    }
}
