//
//  SpritePkm.swift
//  PokemonExtramon
//
//  Created by Lion on 30/04/2024.
//

import SwiftUI


struct SpritePkm: View {
    var pokemon: PokemonEntities
    var frame : CGFloat
    var minWidth : CGFloat
    var body: some View {
        ZStack {
            if let imageURL = URL(string: pokemon.sprite?.regular ?? "") {
                GeometryReader { geometry in
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: geometry.size.width)
                    } placeholder: {
                        ProgressView()
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
        SpritePkm(pokemon: pokemon, frame: 200, minWidth: 200)
    }
}
