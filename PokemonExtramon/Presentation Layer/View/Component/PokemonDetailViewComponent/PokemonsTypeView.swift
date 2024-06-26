//
//  PokemonsTypeView.swift
//  PokemonExtramon
//
//  Created by Lion on 02/05/2024.
//

import SwiftUI

//MARK: Rectangle Embed information
struct PokemonsTypeView: View {
   let pokemon: PokemonEntities
    let width: CGFloat
   var body: some View {
       
           HStack {
               ForEach(0..<pokemon.type.count, id: \.self) { index in
                   
                   if index < pokemon.colorBackground.count {
                       let color = pokemon.colorBackground[index]
                       RoundedRectangle(cornerRadius: 30, style: .continuous)
                           .fill(color)
                           .frame(width: width, height: 40)
                           .overlay(
                            Text(pokemon.type[index].name!)
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .padding(.horizontal, 4)
                            )
                   }
               }
           }
   }
}

    struct PokemonsTypeView_Previews: PreviewProvider {
        static var previews: some View {
            let pokemon = PokemonViewModel.mockPokemon().pokemon[0]
            PokemonsTypeView(pokemon: pokemon, width: 70)
        }
    }
