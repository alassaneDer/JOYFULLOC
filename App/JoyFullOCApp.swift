//
//  JoyFullOCApp.swift
//  JoyFullOC
//
//  Created by Alassane Der on 11/03/2025.
//

import SwiftUI

@main
struct JoyFullOCApp: App {
    @ObservedObject var viewmodel: HomeViewModel = HomeViewModel(dataProvider: ClothingDataProvider())
    
    var body: some Scene {
        WindowGroup {
            HomeView(homeViewmodel: viewmodel)
        }
    }
}
