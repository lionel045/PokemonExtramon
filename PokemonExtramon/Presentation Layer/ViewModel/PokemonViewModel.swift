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
    @Published var pokemonTenResult : [PokemonEntities] = []
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
                self.retrieveTenFirstResult() // Appel ici après le chargement complet

            })
            .store(in: &cancellables)
    }
    
    func getPokemonById(_ id: Int) -> PokemonEntities? {
        return pokemon.first {$0.id == id}
     }
    
  
    func retrieveTenFirstResult() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let strongSelf = self else {return}
            let newPokemons = strongSelf.pokemon.filter { !strongSelf.pokemonTenResult.contains($0) }
            let pokemonsToAdd = Array(newPokemons.prefix(10))
            strongSelf.pokemonTenResult.append(contentsOf: pokemonsToAdd)
        }
    }

}

extension PokemonViewModel {
    convenience init(testData: [PokemonEntities]) {
        self.init()
        self.pokemon = testData
    }
}
