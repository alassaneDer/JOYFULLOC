//
//  CoreLoader.swift
//  JoyFullOC
//
//  Created by Alassane Der on 15/03/2025.
//

import Foundation

final class CoreLoader {
    private let store: ClothingStoreProtocol
    
    init(store: ClothingStoreProtocol) {
        self.store = store
    }
}

extension CoreLoader {
    enum saveError: Error {
        case failed
    }
    
    func saveAll(_ items: [ClothingItem]) throws {
        do {
            try store.insertAll(items)
        } catch {
            throw saveError.failed
        }
    }
}

extension CoreLoader {
    enum LoadError: Error {
        case failed
        case notFound
        case failedToDeleteDuplicates
    }
    
    func removeDuplicates() throws {
        do {
            try store.removeDuplicates()
        } catch {
            throw LoadError.failedToDeleteDuplicates
        }
    }
    
    func load() throws -> [ClothingItem] {
        do {
            let items = try store.retrieveAll()
            if items.isEmpty {
                throw LoadError.notFound
            }
            return items
        } catch {
            throw LoadError.failed
        }
    }
    
    /// not used for now
    func loadOneItem(_ clothingItem: ClothingItem) throws -> ClothingItem? {
        do {
            let items = try store.retrieve(clothingItem)
            return items
        } catch {
            throw LoadError.failed
        }
    }
}

/// not used for now
extension CoreLoader {
    enum UpdateError: Error {
        case failed
    }
    func updateLikes(for itemId: Int, newLikes: Int) throws {
        do {
            try store.updateLikes(for: itemId, newLikes: newLikes)
        } catch {
            throw UpdateError.failed
        }
    }
}

extension CoreLoader {
    enum UpdateErrors: Error {
        case failed
    }
    func update(_ clothingItem: ClothingItem) throws {
        do {
            try store.update(clothingItem)
        } catch {
            throw UpdateErrors.failed
        }
    }
}
