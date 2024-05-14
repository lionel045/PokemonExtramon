//
//  SpritePkm.swift
//  PokemonExtramon
//
//  Created by Lion on 30/04/2024.
//
import SwiftUI

struct SpritePkm: View {
    var pokemon: PokemonEntities
    var frame: CGFloat
    
    var body: some View {
        ZStack {
            if let imageURLString = pokemon.sprite?.regular, let imageURL = URL(string: imageURLString) {
                GeometryReader { geometry in
                    CacheAsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .frame(minWidth: geometry.size.width)
                        case .failure:
                            Image(systemName: "photo")  // Assuming you have a fallback image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                .frame(minHeight: frame)
            } else {
                ProgressView()
            }
        }
    }
}


struct SpritePkm_Previews: PreviewProvider {
    static var previews: some View {
        let pokemon = PokemonViewModel.mockPokemon().pokemon[0]
        SpritePkm(pokemon: pokemon, frame: 200)
    }
}
