//
//  ManagedPicture+Extensions.swift
//  JoyFullOC
//
//  Created by Alassane Der on 15/03/2025.
//

import CoreData

extension ManagedPicture {
    
    static func find(by id: UUID, in context: NSManagedObjectContext) throws -> ManagedPicture? {
        let request = NSFetchRequest<ManagedPicture>(entityName: entity().name!)
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        
        return try context.fetch(request).first
    }
    
    static func findAll(in context: NSManagedObjectContext) throws -> [ManagedPicture] {
        let request = NSFetchRequest<ManagedPicture>(entityName: entity().name!)
        request.returnsObjectsAsFaults = false
        return try context.fetch(request)
    }
    
    static func newInstance(context: NSManagedObjectContext) -> ManagedPicture {
        return ManagedPicture(context: context)
    }
    
    
    /// conversions
        /// /// i use these extensions to convert managedPicture from coredata to pictureItem
        /// and the second: for inverse : pictureItem to managedPicture
    func toDomain() -> PictureItem {
        return PictureItem(id: id, url: url, description: imageDescription)
    }
    
    static func fromDomain(_ picture: PictureItem, context: NSManagedObjectContext) -> ManagedPicture {
        let managedPicture = ManagedPicture(context: context)
        managedPicture.id = picture.id
        managedPicture.url = picture.url
        managedPicture.imageDescription = picture.description
        
        return managedPicture
    }
}

