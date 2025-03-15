//
//  ClothingDataProvider.swift
//  JoyFullOC
//
//  Created by Alassane Der on 15/03/2025.
//

import Foundation

//@MainActor
class ClothingDataProvider: DataProvider {
        func fetch(_ clothingItem: ClothingItem) /*async*/ throws -> ClothingItem? {
            try coreLoader.loadOneItem(clothingItem)
        }
    
        func update(_ clothingItem: ClothingItem) /*async*/ throws {
            try coreLoader.update(clothingItem)
        }
    
    func FetchItems() async throws -> [ClothingItem] {
        let items = await loadFromCoreData()
        if items.isEmpty {
            await saveOnCoreData()
        }
        
        let newItems = await loadFromCoreData()
        return newItems
    }
    
    
    private var apiLoader: ApiLoader
    let coreLoader: CoreLoader
    
    init(apiLoader: ApiLoader = ApiLoader(), coreLoader: CoreLoader) {
        self.apiLoader = apiLoader
        self.coreLoader = coreLoader
    }
    
    /// ==> Convinence init for prod
    convenience init() {
        do {
            let storeURL = FileManager.default
               .urls(for: .applicationSupportDirectory, in: .userDomainMask)
               .first!
               .appendingPathComponent("JoyFullStore.sqlite")
            
            let coreDataStore = try CoreDataClothing(storeURL: storeURL, contextQueue: .main)
            let loader = CoreLoader(store: coreDataStore)
            self.init(coreLoader: loader)
        } catch {
            fatalError()
        }
    }
    
    // MARK: - Api
    func loadFromApi() async throws -> [ClothingItem] {
        do {
            let request = EndPoint.request()
            let items = try await apiLoader.loadClothes(from: request)
            
            return items
        } catch {
            print("Can't load clothes from API.")
            return []
        }
    }
    
    // MARK: - Coredata
    
    func saveOnCoreData() async {
        do {
            let items = try await loadFromApi()
            try coreLoader.saveAll(items)
        } catch {
            print("can't save datas on coredata")
        }
    }
    
    @MainActor
    func loadFromCoreData() -> [ClothingItem] {
        do {
            return try coreLoader.load()
        } catch {
            print("can't load datas from coredata")
            return []
        }
    }
}







// MARK- a voir
//    func FetchItems() /*async*/ async throws -> [ClothingItem] {
//        print("fonction appélé fetching...")
//
//
////        let itemsFromCore = try await loadFromCoreData()
////        print("Nombre d'items chargés depuis CoreData : \(itemsFromCore.count)")    ///
////        if !itemsFromCore.isEmpty {
////            return itemsFromCore
////        } else {
//            let apiItems = try await loadFromApi()
//            print("Nombre d'items récupérés depuis l'API : \(apiItems.count)")  ///
//
//            try /*await*/ saveOnCoreData(items: apiItems)
//
//        print("Items saved on core data")
//            let reloadedItemsFromCore = try /*await*/ loadFromCoreData()
//        print("Données enregistrées dans CoreData, rechargement... \(reloadedItemsFromCore)")
//            return reloadedItemsFromCore
//              ///
//
////        }
//    }
//
//    func fetch(_ clothingItem: ClothingItem) /*async*/ throws -> ClothingItem? {
//        try coreLoader.loadOneItem(clothingItem)
//    }
//
//    func update(_ clothingItem: ClothingItem) /*async*/ throws {
//        try coreLoader.update(clothingItem)
//    }
//
//
//
//
//
//
//    // MARK: - coredata
//    func saveOnCoreData(items: [ClothingItem]) /*async*/ throws {
////        do {
////            let items = try await loadFromApi()   /// enlever car ne peut pas etre dans coreloader
//            try coreLoader.saveAll(items)
//        print("Save success \(items.count)")
////        } catch {
////            print("can't save datas on coredata")
////        }
//    }
//
//    func loadFromCoreData() /*async*/ throws -> [ClothingItem] {
////        do {
//            return try coreLoader.load()
////        } catch {
////            print("can't load datas from coredata")
////        }
//    }
//
//
