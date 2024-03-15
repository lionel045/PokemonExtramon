//
//  PokemonViewModel.swift
//  PokemonExtramon
//
//  Created by Lion on 08/03/2024.
//

import Foundation
import Combine
import SwiftUI
class PokemonViewModel: ObservableObject {
    @Published var pokemon : [PokemonEntities] = []
    @Published var searchText = ""
    private var pokemonDataSource: PokemonDataSource
    private var pokemonRepository: PokemonRepoInterface
    private var pokemonUseCases: FetchPokemonUseCase
    
    init() {
        self.pokemonDataSource = PokemonDataSourceImpl()
          self.pokemonRepository = PokemonRepoImpl(dataSource: pokemonDataSource)
          self.pokemonUseCases = FetchPokemonUseCaseImpl(repo: pokemonRepository)
        
    }
    
    var searchPokemon: [PokemonEntities] {
        guard !searchText.isEmpty else {return pokemon }
        return  pokemon.filter { pokemon in
         let name = pokemon.name.lowercased()
            return name.contains(searchText.lowercased())
        }
    }
    private var cancellables = Set<AnyCancellable>()
    

    func fetchPokemonUseCase() {
        pokemonUseCases.execute()
            .receive(on: RunLoop.main)
            .sink (receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Succes")
                    
                case .failure(let error):
                    print("Error de decodage : \(error.localizedDescription)")
                }
                
            }, receiveValue: { pokemon in
                self.pokemon = pokemon
            })
            .store(in: &cancellables)
        
    }
    
    func getPokemonById(_ id: Int) -> PokemonEntities? {
        return pokemon.first {$0.id == id}
     }
    
}



extension PokemonViewModel {
    convenience init(testData: [PokemonEntities]) {
        self.init()
        self.pokemon = testData
    }
}
