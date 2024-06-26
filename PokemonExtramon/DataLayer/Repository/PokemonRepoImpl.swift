//
//  PokemonRepoImpl.swift
//  PokemonExtramon
//
//  Created by Lion on 11/03/2024.
//

import Foundation
import Combine

struct PokemonRepoImpl : PokemonRepoInterface {
    
    var dataSource : PokemonDataSource
    
    init(dataSource: PokemonDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchPokemon() -> AnyPublisher<[PokemonEntities], any Error> {
        
        dataSource.fetchPokemon()
        
    }
    
}

