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
    @ObservedObject var viewModel: PokemonViewModel
    @State var currentPage = 0
    @State var currentLabel = ""
    
    var body: some View {
        if pokemon.haveEvolution {
            VStack(spacing: 2) {
                Text(currentLabel)
                    .font(.title)
                    .foregroundColor(pokemon.colorBackground.first)
                    .frame(maxWidth: .infinity)
                
                TabView(selection: $currentPage) {
                    ForEach(viewModel.evolutions.indices, id: \.self) { index in
                
                    SpritePkm(pokemon: viewModel.evolutions[index], frame: UIScreen.main.bounds.height < 700 ? 60 : 70)
                        .tag(index)
                        
                    }
                  
                }
                
                .onChange(of: currentPage) { oldValue ,newValue in
                    currentLabel = updateLabelEvolution()
                }
                .tabViewStyle(.page(indexDisplayMode: .automatic))

                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    viewModel.getEvolutions(for: pokemon)
                    currentLabel = updateLabelEvolution()
                }
            }
        } else {
            EmptyView()
        }
    }
    
    func updateLabelEvolution() -> String {
        if currentPage == 0 && pokemon.evolution.pre != nil {
            return "PreEvolution"
        } else {
            return "Evolution"
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
