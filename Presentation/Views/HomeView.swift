//
//  HomeView.swift
//  JoyFullOC
//
//  Created by Alassane Der on 14/03/2025.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var homeViewmodel: HomeViewModel
    
    @Environment(\.self) private var env
    @StateObject private var orientationManager = DeviceOrientationManager()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.accessibleBackground(env)
                    .ignoresSafeArea(.all)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(homeViewmodel.categories.keys.sorted(), id: \.self) { key in
                            RowView(
                                homeViewmodel: homeViewmodel,
                                items: homeViewmodel.categories[key]!,
                                categoryName: key,
                                action: { item in
                                    Task {
                                        await homeViewmodel.updateLikes(item)
                                    }
                                }
                            )
                        }
                    }
                }
                .accessibilityHint("Balayez vers le bas pour voir différentes catégories.")
            }
            .overlay(alignment: .trailing) {
                         if orientationManager.isLandscapeOnIpad && homeViewmodel.selectedItem != nil {
                             DetailView(homeViewmodel: homeViewmodel, clothingItem: homeViewmodel.selectedItem)
                                 .frame(width: 426)
                         }
                     }
                     .onAppear(perform: {
                         Task {
                             await homeViewmodel.loadClothingItems()
                         }
                     })
            .navigationTitle("Accueil")
            .navigationBarTitleDisplayMode(.inline)
            .accessibilityLabel("Accueil")
        }
    }
}

//
//struct HomeView: View {
//    
//    @ObservedObject var homeViewmodel: HomeViewModel
//    
//    @Environment(\.self) private var env
//    @StateObject private var orientationManager = DeviceOrientationManager()
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color.accessibleBackground(env)
//                    .ignoresSafeArea(.all)
//                
//                ScrollView(.vertical, showsIndicators: false) {
//                    VStack {
//                        ForEach(homeViewmodel.categories.keys.sorted(), id: \.self) { key in
//                            RowView(
//                                homeViewmodel: homeViewmodel,
//                                items: homeViewmodel.categories[key]!,
//                                categoryName: key,
//                                action:  {
//                                    item in
//                                    Task {
//                                        await homeViewmodel.updateLikes(item)
//                                    }
//                                }
//                            )
//                        }
//                    }
//                }
//            }
//            .overlay(alignment: .trailing) {
//                if orientationManager.isLandscapeOnIpad && homeViewmodel.selectedItem != nil {
//                    DetailView(homeViewmodel: homeViewmodel, clothingItem: homeViewmodel.selectedItem)
//                        .frame(width: 426)
//                }
//            }
//            .onAppear(perform: {
//                Task {
//                    await homeViewmodel.loadClothingItems()
//                }
//            })
//            .navigationTitle("Home")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}

#Preview {
    HomeView(homeViewmodel: HomeViewModel(dataProvider: PreviewsDatas()))
}
