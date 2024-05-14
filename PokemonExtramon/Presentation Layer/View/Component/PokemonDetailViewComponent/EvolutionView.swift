//
//  EvolutionView.swift
//  PokemonExtramon
//
//  Created by Lion on 03/05/2024.
//

import SwiftUI


//MARKS: View charged to display the evolution's pokemon
struct EvolutionView: View {
    let pokemon: PokemonEntities
    
    @Binding var showEvolution: Bool
    @ObservedObject var viewModel : PokemonViewModel
    var body: some View {
        
        if  pokemon.haveEvolution {
            VStack(spacing: -1) {
                Text("Evolutions")
                    .font(.title)
                    .foregroundColor(pokemon.colorBackground.first)
                    .frame(maxWidth: .infinity)
                HStack(spacing: 5) {
                    
                    ForEach(viewModel.evolutions, id: \.id) { evolution in
                        
                        SpritePkm(pokemon: evolution, frame: UIScreen.main.bounds.height < 700 ? 60 : 100)
                                  
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
