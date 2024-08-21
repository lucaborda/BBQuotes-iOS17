//
//  CharacterView.swift
//  BBQuotes17
//
//  Created by Luca Borda on 31/07/2024.
//

import SwiftUI

struct CharacterView: View {
    let character: Character
    let show: String
    
    @State var selectedImage = 0
    
    var body: some View {
        GeometryReader { geo in
            ScrollViewReader { proxy in
                ZStack(alignment: .top) {
                    Image (show.removeCaseAndSpaces())
                        .resizable()
                        .scaledToFit()
                    
                    ScrollView {
                        TabView (selection: $selectedImage) {
                            ForEach(Array(character.images.enumerated()), id: \.offset) { index, characterImage in
                                AsyncImage(url: characterImage) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .tag(index)
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(width: geo.size.width / 1.2, height: geo.size.height / 1.7)
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.top, 60)
                        .onAppear {
                            selectedImage = Int.random(in: 0..<character.images.count)
                        }
                        
                        
                        VStack(alignment: .leading) {
                            Text(character.name)
                                .font(.title)
                            
                            Text("Portrayed By: \(character.portrayedBy)")
                                .font(.subheadline)
                            
                            Divider()
                            
                            Text("Born: \(character.birthday)")
                            
                            Divider()
                            
                            Text("Occupations:")
                            
                            ForEach(character.occupations, id: \.self) { occupation in
                                Text("•\(occupation)")
                                    .font(.subheadline)
                            }
                            
                            Divider()
                            
                            Text("Nicknames:")
                            
                            if character.aliases.count > 0 {
                                ForEach(character.aliases, id: \.self) { alias in
                                    Text("•\(alias)")
                                        .font(.subheadline)
                                }
                            } else {
                                Text("None")
                                    .font(.subheadline)
                            }
                            
                            Divider()
                            
                            DisclosureGroup("Status (spoiler alert!)") {
                                VStack (alignment: .leading) {
                                    Text(character.status)
                                        .font(.title)
                                    
                                    if let death = character.death {
                                        AsyncImage(url: death.image) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(.rect(cornerRadius: 15))
                                                .onAppear {
                                                    withAnimation {
                                                        proxy.scrollTo(1, anchor: .bottom)
                                                    }
                                                }
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        
                                        Text("How: \(death.details)")
                                            .padding(.bottom, 7)
                                        
                                        Text("Last words: \"\(death.lastWords)\"")
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .tint(.primary)
                            
                        }
                        .frame(width: geo.size.width/1.25, alignment: .leading)
                        .padding(.bottom, 50)
                        .id(1)
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    CharacterView(character: ViewModel().character, show: Constants.bbName)
}
