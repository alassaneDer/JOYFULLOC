//
//  CoreClothing.swift
//  JoyFullOC
//
//  Created by Alassane Der on 15/03/2025.
//

import CoreData

final class CoreDataClothing {
    private static let modelName = "JoyFullStore"
    private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataClothing.self))
    
    private let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    enum StoreError: Error {
        case modelNotFound
        case failedToLoadPersistenceContainer(Error)
    }
    
    enum ContextQueue {
        case main
        case background
    }
    
    var contextQueue: ContextQueue {
        context == container.viewContext ? .main : .background
    }
    
    init(storeURL: URL, contextQueue: ContextQueue = .background) throws {
        guard let model = CoreDataClothing.model else {
            throw StoreError.modelNotFound
        }
        
        do {
            container = try NSPersistentContainer.load(name: CoreDataClothing.modelName, model: model, url: storeURL)
            context = contextQueue == .main ? container.viewContext : container.newBackgroundContext()
        } catch {
            throw StoreError.failedToLoadPersistenceContainer(error)
        }
    }
    
    func perform(_ action: @escaping () -> Void) {
        context.perform(action)
    }
    
    private func cleanUpReferencesToPersistentStores() {
        context.perform { [weak self] in
            guard let self = self else { return } /// Éviter tout accès à un `self` déjà désalloué
            let coordinator = self.container.persistentStoreCoordinator
            try? coordinator.persistentStores.forEach(coordinator.remove)
        }
    }
    
    deinit {
        cleanUpReferencesToPersistentStores()
    }
}
