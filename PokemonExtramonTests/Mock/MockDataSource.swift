//
//  MockDataSource.swift
//  PokemonExtramonTests
//
//  Created by Lion on 02/06/2024.
//

import Foundation
import Combine
import XCTest

class MockDataSource: PokemonDataSource {
    var cancellables = Set<AnyCancellable>()

    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }()

    func fetchPokemon() -> AnyPublisher<[PokemonEntities], any Error> {
        guard let url = URL(string: "https://tyradex.vercel.app/api/v1/gen/1") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [PokemonData].self, decoder: jsonDecoder)
            .map { pokemonArray in
                return pokemonArray.map { $0.toEntity() }
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
