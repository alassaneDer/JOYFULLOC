//
//  ManagedPicture.swift
//  JoyFullOC
//
//  Created by Alassane Der on 15/03/2025.
//

import CoreData

@objc(ManagedPicture)
class ManagedPicture: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var url: String
    @NSManaged var imageDescription: String
}
