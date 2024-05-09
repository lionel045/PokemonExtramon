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
    //    @Published var pokemonTenResult : [PokemonEntities] = []
    @Published var searchText = ""
    
    var pokemonUseCases = FetchPokemonUseCaseImpl(repo: PokemonRepoImpl(dataSource: PokemonDataSourceImpl()))
    
    var searchPokemon: [PokemonEntities] {
        guard !searchText.isEmpty else {return pokemon }
        return  pokemon.filter { pokemon in
            let name = pokemon.name.lowercased().folding(options: .diacriticInsensitive, locale: .current)
            return name.contains(searchText.lowercased())
        }
    }
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Api call for get all pokemon in the pokemon list
    
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
    
    
    //MARK: getter for add the next  evolution or preEvolution
    func getEvolutions(for pokemon: PokemonEntities) -> [PokemonEntities] {
        var evolutions: [PokemonEntities] = []
        
        if let preEvolutions = pokemon.evolution.pre {
            for preEvolution in preEvolutions {
                if let preEvolutionId = preEvolution.pokedexId {
                    if let preEvolutionPokemon = getPokemonById(preEvolutionId) {
                        evolutions.append(preEvolutionPokemon)
                    }
                }
            }
        }
        
        evolutions.append(pokemon)
        print(pokemon.evolution.next?.count ?? 0)
        if let nextEvolutions = pokemon.evolution.next {
            if nextEvolutions.count == 1 {
                // S'il n'y a qu'une seule évolution, ajoutez-la à la fin de la liste
                if let nextEvolution = nextEvolutions.first {
                    if let nextEvolutionId = nextEvolution.pokedexId {
                        if let nextEvolutionPokemon = getPokemonById(nextEvolutionId) {
                            evolutions.append(nextEvolutionPokemon)
                        }
                    }
                }
            }  else {
                //
                for nextEvolution in nextEvolutions {
                    if let nextEvolutionId = nextEvolution.pokedexId {
                        if let nextEvolutionPokemon = getPokemonById(nextEvolutionId) {
                            evolutions.append(nextEvolutionPokemon)
                        }
                    }
                }
            }
        }
        
        return evolutions
    }

    
    
}

extension PokemonViewModel {
    static func mockPokemon() -> PokemonViewModel {
        let viewModel = PokemonViewModel()
        
        viewModel.pokemon = [
                PokemonEntities(id: 1, generation: 1, category: "Graine", name: "Bulbizarre", stats: PokemonStats(hp: 45, attack: 49, defense: 49, spttack: 65, spdefense: 65, speed: 45), type: [TypeEntites(name: "Plante", image: nil)], talentsEntites: [TalentEntites(name: "Engrais", tc: false)], sprite: SpriteEntites(regular: "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/1/regular.png", shiny: nil), evolution: EvolutionEntites(pre: nil, next: nil, mega: nil), height: "0.7m", weight: "6.9kg", eggGroups: nil, sexe: nil, catchRate: nil, level100: nil),
                PokemonEntities(id: 2, generation: 1, category: "Graine", name: "Herbizarre", stats: PokemonStats(hp: 60, attack: 62, defense: 63, spttack: 80, spdefense: 80, speed: 60), type: [TypeEntites(name: "Plante", image: nil)], talentsEntites: [TalentEntites(name: "Engrais", tc: true)], sprite: SpriteEntites(regular: "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/2/regular.png", shiny: nil), evolution: EvolutionEntites(pre: nil, next: nil, mega: nil), height: "1.0m", weight: "13.0kg", eggGroups: nil, sexe: nil, catchRate: nil, level100: nil),
                PokemonEntities(id: 3, generation: 1, category: "Graine", name: "Florizarre", stats: PokemonStats(hp: 80, attack: 82, defense: 83, spttack: 100, spdefense: 100, speed: 80), type: [TypeEntites(name: "Plante", image: nil)], talentsEntites: [TalentEntites(name: "Engrais", tc: true)], sprite: SpriteEntites(regular: "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/3/regular.png", shiny: nil), evolution: EvolutionEntites(pre: nil, next: nil, mega: nil), height: "2.0m", weight: "100.0kg", eggGroups: nil, sexe: nil, catchRate: nil, level100: nil)
            ]
        return viewModel
    }
}
