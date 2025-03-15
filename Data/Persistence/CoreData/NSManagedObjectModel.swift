//
//  NSManagedObjectModel.swift
//  JoyFullOC
//
//  Created by Alassane Der on 15/03/2025.
//

import CoreData

extension NSManagedObjectModel {
    static func with(name: String, in bundle: Bundle) -> NSManagedObjectModel? {
        return bundle
            .url(forResource: name, withExtension: "momd")
            .flatMap { NSManagedObjectModel(contentsOf: $0) }
    }
}
