//
//  PokemonRepoInterface.swift
//  PokemonExtramon
//
//  Created by Lion on 11/03/2024.
//

import Foundation
import Combine

protocol PokemonRepoInterface {
    func fetchPokemon() -> AnyPublisher<[PokemonEntities], Error>
}
