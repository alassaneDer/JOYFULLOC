//
//  DetailView.swift
//  JoyFullOC
//
//  Created by Alassane Der on 15/03/2025.
//

import SwiftUI


struct DetailView: View {
    
    @StateObject var homeViewmodel: HomeViewModel
    
    @Environment(\.self) private var env
    var clothingItem: ClothingItem? = PreviewsDatas().clothes[0]
    
    @State var isSharing: Bool = false
    
    @State var text: String = "Partagez vos impressions sur cette pièce ici"
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(hex: "EFEFF4")
                    .ignoresSafeArea(.all)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        if let clothingItem = clothingItem {
                            VStack {
                                AsyncImage(url: URL(string: clothingItem.picture.url)) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                            .frame(minWidth: geometry.size.width, maxHeight: geometry.size.height * 2/3)
                                            .accessibilityLabel(clothingItem.name)
                                            .accessibilityHint("Image du vêtement.")
                                            .accessibilityAddTraits(.isImage)
                                    case .failure:
                                        Image(systemName: "exclamationmark.triangle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: .infinity)
                                            .accessibilityLabel("Image indisponible")
                                    default:
                                        ProgressView()
                                    }
                                }
                                .overlay(alignment: .topTrailing) {
                                    SharedButton(isSharing: isSharing)
                                        .padding()
                                        .onTapGesture {
                                            isSharing.toggle()
                                        }
                                }
                            }
                            
                            PricesView(clothingItem: clothingItem, isSelected: false)
                                .font(.body)
                                .padding(.horizontal)
                            
                            Text(clothingItem.picture.description)
                                .accessibilityLabel("Description: \(clothingItem.picture.description)")
                            
                            HStack {
                                Image("picture2_3")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle()).frame(width: 50)
                                
                                ForEach(1...5, id: \.self) { index in
                                    Button(action: {
                                        Task {
                                            await homeViewmodel.updateRatings(clothingItem, newUserRating: Double(index))
                                        }
                                    }) {
                                        Image(systemName: index <= Int(clothingItem.userRating) ? "star.fill" : "star")
                                            .font(.system(size: 25))
                                            .foregroundStyle(index <= Int(clothingItem.userRating) ? Color.orange : Color.black.opacity(0.5))
                                    }
                                    .accessibilityLabel("\(index) étoiles")
                                }
                            }
                            
                            // MARK: user comments
                            TextEditor(text: $text)
                                .textInputAutocapitalization(.never)
                                .foregroundStyle(Color.black.opacity(0.5))
                                .multilineTextAlignment(.leading)
                                .autocorrectionDisabled(true)
                                .scrollContentBackground(.hidden)
                                .frame(minHeight: 60)
                                .padding(.horizontal)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black.opacity(0.5), lineWidth: 1)
                                }
                            
                        }
                    }
                    .padding(.horizontal)
                }
                .accessibilityHint("Balayez pour voir plus d'informations.")
            }
        }
    }
}







//
//struct DetailView: View {
//
//    @StateObject var homeViewmodel: HomeViewModel
//
//    @Environment(\.self) private var env
//    var clothingItem: ClothingItem? = PreviewsDatas().clothes[0]
//
//    @State var isSharing: Bool = false
//
//    @State var text: String = "Partagez vos impressions sur cette pièce ici"    /// à suprimer
//
//    var body: some View {
//
//        GeometryReader { geometry in
//
//            ZStack {
//                Color(hex: "EFEFF4")
//                    .ignoresSafeArea(.all)
//
//
//                ScrollView {
//                    VStack(alignment: .leading) {
//
//                        if let clothingItem = clothingItem {
//                            VStack {
//                                AsyncImage(url: URL(string: clothingItem.picture.url)) { phase in
//                                    switch phase {
//                                    case .success(let image):
//                                        image
//                                            .resizable()
//                                            .scaledToFit()
//                                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
//                                            .frame(minWidth: geometry.size.width, maxHeight: geometry.size.height * 2/3)
//                                    case .failure:
//                                        Image(systemName: "exclamationmark.triangle")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(maxWidth: .infinity)
//                                    default:
//                                        ProgressView()
//                                    }
//                                }
//                                .overlay(alignment: .bottomTrailing) {
//                                    ButtonLikes(
//                                        action: {
//                                            item in
//                                            Task {
//                                                await homeViewmodel.updateLikes(item)
//                                            }
//                                        },
//                                        clothingItem: clothingItem
//                                    )
//                                }
//                            }
//                            .overlay(alignment: .topTrailing) {
//                                SharedButton(isSharing: isSharing)
//                                    .padding()
//                                    .onTapGesture {
//                                        isSharing.toggle()
//                                    }
//                            }
//
//                            /// prices
//
//                            //            }
//
//                            PricesView(clothingItem: clothingItem, isSelected: false)
//                                .font(.body)
//                                .padding(.horizontal)
////                                .lineLimit(2)
////                                .minimumScaleFactor(0.8) /// Évite que le texte ne soit tronqué
////                                .padding(.top, 4) /// Laisse de l’espace sous l’image
//                            ///
//                            ///
//
//
//                            Text(clothingItem.picture.description)
//
//                            // MARK: profile and stars
//                            HStack {
//                                Image("picture2_3")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .clipShape(Circle()).frame(width: 50)
//
//                                ForEach(1...5, id: \.self) { index in
//                                    Button(action: {
//                                        Task {
//                                            await homeViewmodel.updateRatings(clothingItem, newUserRating: Double(index))
//                                        }
//                                    }, label: {
//                                        Image(systemName: index <= Int(clothingItem.userRating) ? "star.fill" : "star")
//                                            .font(.system(size: 25))
//                                            .foregroundStyle( index <= Int(clothingItem.userRating) ? Color.orange : Color.black.opacity(0.5))
//                                    })
//                                }
//
//                            }
//
//                            // MARK: user comments
//                            TextEditor(text: $text)
//                                .textInputAutocapitalization(.never)
//                                .foregroundStyle(Color.black.opacity(0.5))
//                                .multilineTextAlignment(.leading)
//                                .autocorrectionDisabled(true)
//                                .scrollContentBackground(.hidden)
//                                .frame(minHeight: 60)
//                                .padding(.horizontal)
//                                .overlay {
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(Color.black.opacity(0.5), lineWidth: 1)
//                                }
//
//                        }
//                    }.padding(.horizontal)
//                }
//
//
//
//
//            }
//
//        }
//    }
//}
#Preview {
    DetailView(homeViewmodel: HomeViewModel(dataProvider: PreviewsDatas()))
}


/*
 
 @State var clothingItem: ClothingItem?
 @State var text: String = "Partagez vos impressions sur cette pièce ici"
 
 var action: (ClothingItem) -> Void = {_ in }
 var rating: Int = 3
 
 
 
 
 
 ZStack {
 Color(hex: "EFEFF4")
 .ignoresSafeArea(.all)
 
 ScrollView {
 if let clothingItem = clothingItem {
 VStack(alignment: .leading, spacing: 0) {
 ItemView(
 clothingItem: clothingItem,
 action: {
 item in
 Task {
 await homeViewmodel.updateLikes(item)
 }
 }
 )
 
 Text(clothingItem.picture.description)
 
 // MARK: profile and stars
 HStack {
 Image("picture3_4")
 .resizable()
 .aspectRatio(contentMode: .fit)
 .clipShape(Circle()).frame(width: 50)
 
 ForEach(1...5, id: \.self) { index in
 Button(action: {
 homeViewmodel.updateRatings(clothingItem, newUserRating: Double(index))
 }, label: {
 Image(systemName: index <= Int(clothingItem.userRating) ? "star.fill" : "star")
 .font(.system(size: 25))
 .foregroundStyle( index <= Int(clothingItem.userRating) ? Color.orange : Color.black.opacity(0.5))
 })
 }
 
 }
 
 // MARK: user comments
 TextEditor(text: $text)
 .textInputAutocapitalization(.never)
 .foregroundStyle(Color.black.opacity(0.5))
 .multilineTextAlignment(.leading)
 .autocorrectionDisabled(true)
 .scrollContentBackground(.hidden)
 .frame(height: 60)
 .overlay {
 RoundedRectangle(cornerRadius: 10)
 .stroke(Color.black.opacity(0.5), lineWidth: 1)
 }
 }
 .padding(8)
 }
 else {
 Text("Select an item.")
 }
 }
 
 }
 
 
 */
