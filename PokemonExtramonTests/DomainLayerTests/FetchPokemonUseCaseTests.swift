//
//  FetchPokemonUseCaseTests.swift
//  PokemonExtramonTests
//
//  Created by Lion on 25/05/2024.
//

import XCTest
import Combine
final class FetchPokemonUseCaseTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    
    // MARK: test useCase with raw value
    func testUseCasefunc(){
        let mockRepo = MockPokemonRepo()
        mockRepo.pokemon = [PokemonEntities(id: 1, generation: 1, category: "Graine", name: "Bulbizarre", stats: PokemonStats(hp: 45, attack: 49, defense: 49, spttack: 65, spdefense: 65, speed: 45), type: [TypeEntites(name: "Plante", image: nil)], talentsEntites: [TalentEntites(name: "Overgrow", tc: true)], sprite: SpriteEntites(regular: "https://example.com", shiny: nil), evolution: EvolutionEntites(pre: nil, next: nil, mega: nil), height: "0.7m", weight: "6.9kg", eggGroups: nil, sexe: nil, catchRate: nil, level100: nil)]
        
        let expectation  = expectation(description: "Fetch pokemon")
        let useCase = FetchPokemonUseCaseImpl(repo: mockRepo)
        useCase.execute()
            .sink(receiveCompletion: { _ in }) { pokemons in
                XCTAssertEqual(pokemons.count, 1)
                XCTAssertEqual(pokemons.first?.name, mockRepo.pokemon.first?.name)
                expectation.fulfill()
            }
        
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.0)
        
    }
}
