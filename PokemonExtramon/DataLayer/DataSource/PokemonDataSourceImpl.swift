//
//  PokemonRepoImpl.swift
//  PokemonExtramon
//
//  Created by Lion on 11/03/2024.
//

import Foundation
import Combine

struct PokemonDataSourceImpl : PokemonDataSource {
    
    var cancellable = Set<AnyCancellable>()

    func fetchPokemon() -> AnyPublisher<[PokemonEntities], any Error> {
        
        guard let url = URL(string: "https://tyradex.vercel.app/api/v1/gen/1") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
          }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [PokemonData].self, decoder: jsonDecoder)
            .map { pokemonArray in
                return pokemonArray.map { $0.toEntity() }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
