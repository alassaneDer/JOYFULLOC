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
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var clothingItem: ClothingItem? = PreviewsDatas().clothes[0]
    
    @State var isSharing: Bool = false
    @State var text: String = "Partagez vos impressions sur cette pièce ici"
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.accessibleBackground(env)
                    .ignoresSafeArea(.all)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        if let clothingItem = clothingItem {
                            AsyncImage(url: URL(string: clothingItem.picture.url)) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geometry.size.width - 16, height: geometry.size.height * 4/5)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                        .accessibilityLabel(clothingItem.name)
                                        .accessibilityHint("Image du vêtement.")
                                        .accessibilityAddTraits(.isImage)
                                        .accessibilitySortPriority(1)
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
                            .accessibilityElement()
                            .accessibilityLabel("image de \(clothingItem.name)")
                            .accessibilityHint("Image du vêtement.")
                            .accessibilityAddTraits(.isImage)
                            .overlay(alignment: .bottomTrailing) {
                                ButtonLikes(
                                    action: { item in
                                        Task {
                                            await homeViewmodel.updateLikes(item)
                                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                        }
                                    },
                                    clothingItem: clothingItem
                                )
                                .accessibilityElement()
                                .accessibilityLabel("Bouton J'aime. cette article a été aimé \(clothingItem.likes) fois.")
                                .accessibilityHint(" Activez pour aimer ou retirer votre like.")
                                .accessibilitySortPriority(2)

                            }
                            .overlay(alignment: .topTrailing) {
                                HStack {
                                    SharedButton(isSharing: isSharing)
                                        .padding()
                                        .onTapGesture {
                                            isSharing.toggle()
                                        }
                                }
                                .accessibilityElement()
                                .accessibilityLabel("Bouton de partage, appyer pour partager l'article")
                                .accessibilityHint("Double tapez pour partager.")
                                .padding()
                            }
                            
                            PricesView(clothingItem: clothingItem, isSelected: false)
                                
                            Text(clothingItem.picture.description)
                                .accessibilityElement()
                                .accessibilityLabel("Description: \(clothingItem.picture.description)")
                            
                            HStack {
                                Image("picture2_3")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                                    .frame(width: DynamicTypeSize.profilePicSize(for: dynamicTypeSize))
                                
                                ForEach(1...5, id: \.self) { index in
                                    Button(action: {
                                        Task {
                                            await homeViewmodel.updateRatings(clothingItem, newUserRating: Double(index))
                                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                        }
                                    }) {
                                        Image(systemName: index <= Int(clothingItem.userRating) ? "star.fill" : "star")
                                            .font(.system(size: DynamicTypeSize.iconSize(for: dynamicTypeSize)))
                                            .foregroundStyle(index <= Int(clothingItem.userRating) ? Color.orange : Color.black.opacity(0.5))
                                    }
                                    Spacer()
                                }
                            }
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("Votre photo de profile, cet article a \(clothingItem.userRating, specifier: "%.f") étoiles sur 5")
                            .frame(maxWidth: geometry.size.width - 16)
                            
                            TextEditor(text: $text)
                                .textInputAutocapitalization(.never)
                                .foregroundStyle(Color.black.opacity(0.5))
                                .multilineTextAlignment(.leading)
                                .minimumScaleFactor(0.8)
                                .autocorrectionDisabled(true)
                                .scrollContentBackground(.hidden)
                                .frame(maxWidth: geometry.size.width - 16, minHeight: DynamicTypeSize.textEditorHeight(for: dynamicTypeSize))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black.opacity(0.5), lineWidth: 1)
                                }
                                .accessibilityLabel("Ajouter un commentaire")
                                .accessibilityHint("Double tapez pour modifier votre commentaire.")
                                .accessibilityValue(text.isEmpty ? "Aucun commentaire saisi" : text)
                            
                            if let comment = clothingItem.userComment {
                                Text(comment)
                            }
                        } else {
                            Text("Sélectionner un article!")
                        }
                    }
                    .padding(8)
                }
                .frame(maxWidth: geometry.size.width - 16)
                .accessibilityHint("Balayez pour voir plus d'informations.")
            }
        }
    }
}


#Preview {
    DetailView(homeViewmodel: HomeViewModel(dataProvider: PreviewsDatas()))
}
