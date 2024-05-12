//
//  EvolutionView.swift
//  PokemonExtramon
//
//  Created by Lion on 03/05/2024.
//

import SwiftUI

struct EvolutionView: View {
    let pokemon: PokemonEntities
    
    @Binding var showEvolution: Bool
    @ObservedObject var viewModel : PokemonViewModel
    var body: some View {
        
        if  pokemon.haveEvolution {
            
            VStack {
                Text("Evolutions")
                    .font(.title)
                    .foregroundColor(pokemon.colorBackground.first)
                    .frame(maxWidth: .infinity)
                HStack(spacing: 5) {
                    
                    ForEach(viewModel.evolutions, id: \.id) { evolution in
                        
                        SpritePkm(pokemon: evolution, frame: 60, minWidth: 60)
                                  
                    }
                    .padding(.bottom, 40)
                }
            }
            .onAppear {
                viewModel.getEvolutions(for: pokemon)
                
            }
        }
        else {
            EmptyView()
        }
    }
}
struct EvolutionView_Previews: PreviewProvider {
    static var previews: some View {
        @State var showEvolution = true
        let pokemon =  PokemonViewModel.mockPokemon().pokemon[0]
        EvolutionView(pokemon: pokemon, showEvolution: $showEvolution , viewModel: PokemonViewModel.mockPokemon() )
    }
}
