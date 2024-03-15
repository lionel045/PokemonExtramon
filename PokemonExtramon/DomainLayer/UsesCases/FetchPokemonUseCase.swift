//
//  FetchPokemonUseCase.swift
//  PokemonExtramon
//
//  Created by Lion on 11/03/2024.
//

import Foundation
import Combine
protocol FetchPokemonUseCase {
    
    func execute() -> AnyPublisher<[PokemonEntities], Error>

}
