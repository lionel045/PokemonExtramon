//
//  Labelpkm.swift
//  PokemonExtramon
//
//  Created by Lion on 02/05/2024.
//

import SwiftUI

struct Labelpkm: View {
    var pokemon: PokemonEntities
    var formattedId: String {
        String(format: "%03d", pokemon.id)
    }
    var body: some View {
        VStack {

            HStack {
                Text("#\(formattedId)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(pokemon.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }
}
struct Labelpkm_Previews: PreviewProvider {
    static var previews: some View {
        let pokemon = PokemonViewModel.mockPokemon().pokemon[0]
        Labelpkm(pokemon: pokemon)
    }
}
