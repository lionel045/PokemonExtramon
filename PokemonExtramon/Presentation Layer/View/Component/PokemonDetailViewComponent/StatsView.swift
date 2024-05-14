//
//  StatView.swift
//  PokemonExtramon
//
//  Created by Lion on 29/04/2024.
//

import SwiftUI

//MARK: Pokemon's Stat View
struct StatsView : View {
    var pokemon: PokemonEntities
    var currentStats: Int?
    var nameOfStats : String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                Text(nameOfStats)
                    .font(.system(size: 12, design: .rounded))
                    .foregroundColor(pokemon.colorBackground.first)
                    .frame(width: 32)
                Text("\(currentStats ?? 0 < 100 ? "0" : "")\(currentStats ?? 0)")
                Capsule()
                    .fill(Color(.systemGray2))
                    .frame(width: 220, height: 5) 
                    .overlay(
                        GeometryReader { geometry in
                            let width = min(geometry.size.width, CGFloat(currentStats ?? 0) / geometry.size.width * geometry.size.width)
                            
                            Capsule()
                                .frame(width: width, height: 5) // Réduction de la largeur de la jauge
                                .foregroundColor(pokemon.colorBackground.first)
                        }
                    )
            }
        }
        
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        let pokemon = PokemonViewModel.mockPokemon().pokemon[0]
        
        return VStack {
            StatsView(pokemon: pokemon, currentStats: 85, nameOfStats: "HP")
                .padding()
                .background(Color.white)
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .light)
            
            StatsView(pokemon: pokemon, currentStats: 72, nameOfStats: "Attack")
                .padding()
                .background(Color.white)
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .light)
        }
    }
}

