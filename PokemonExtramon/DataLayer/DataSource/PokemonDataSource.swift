//
//  PokemonDataSource.swift
//  PokemonExtramon
//
//  Created by Lion on 11/03/2024.
//

import Foundation
import Combine

// Interface DataSource

protocol PokemonDataSource {
    
    func fetchPokemon() -> AnyPublisher<[PokemonEntities], Error >
}
