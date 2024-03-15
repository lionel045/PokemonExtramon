//
//  PokeUseCases.swift
//  PokemonExtramon
//
//  Created by Lion on 11/03/2024.
//

import Foundation
import Combine

struct FetchPokemonUseCaseImpl: FetchPokemonUseCase {
    
    var repo: PokemonRepoInterface
    
    func execute() -> AnyPublisher<[PokemonEntities], any Error> {
        return repo.fetchPokemon()
    }
}
