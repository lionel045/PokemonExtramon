//
//  PokeCard.swift
//  PokemonExtramon
//
//  Created by Lion on 12/05/2024.
//

import SwiftUI

struct PokeCard: View {
    let pokemon: PokemonEntities
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width,height: 200)
                .foregroundColor(pokemon.colorBackground.first).opacity(0.5)
                .cornerRadius(20)
            VStack {
                HStack(spacing: -10){
                    VStack{
                        Text(pokemon.name)
                            .font(.system(size: 22,weight: .semibold,design: .rounded))
                            .foregroundColor(.white)
                        PokemonsTypeView(pokemon: pokemon, width: 80)
                    }
                    .padding(.leading, 30)

                    SpritePkm(pokemon: pokemon, frame: 50)
                        .frame(width: 180,height: 190)
                    
                }
            }
        }
    }
}


struct PokeCard_Previews: PreviewProvider {
    static var previews: some View {
        let pokemon = PokemonViewModel.mockPokemon().pokemon[0]
        PokeCard(pokemon: pokemon)
        
            .previewLayout(.sizeThatFits)
    }
}

