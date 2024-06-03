//
//  MockPokemonRepo.swift
//  PokemonExtramonTests
//
//  Created by Lion on 02/06/2024.
//

import Foundation
import Combine


class MockPokemonRepo: PokemonRepoInterface {
    var pokemon: [PokemonEntities] = []
    func fetchPokemon() -> AnyPublisher<[PokemonEntities], any Error> {
        return Just(pokemon)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
