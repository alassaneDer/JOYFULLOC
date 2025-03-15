//
//  ManagedClothing.swift
//  JoyFullOC
//
//  Created by Alassane Der on 15/03/2025.
//

import CoreData

@objc(ManagedClothing)
class ManagedClothing: NSManagedObject {
    @NSManaged var id: Int64
    @NSManaged var name: String
    @NSManaged var likes: Int64
    @NSManaged var price: Double
    @NSManaged var originalPrice: Double
    
    @NSManaged var category: String
    
    /// user comments and ratings
    @NSManaged var userComment: String?
    @NSManaged var userRating: Double
    @NSManaged var isLiked: Bool
    
    /// relation avec managedPictture
    @NSManaged var picture: ManagedPicture
}
