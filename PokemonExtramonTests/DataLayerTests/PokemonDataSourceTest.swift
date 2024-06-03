//
//  PokemonDataSourceTest.swift
//  PokemonExtramonTests
//
//  Created by Lion on 26/05/2024.
//

import XCTest
import Combine
final class PokemonDataSourceTest: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []
    
    func testFetchPokemonSuccess() {
        // Mock JSON data
        let jsonData = """
               [
                   {
                       "pokedexId": 1,
                       "generation": 1,
                       "category": "Pokémon Graine",
                       "name": {
                           "fr": "Bulbizarre",
                           "en": "Bulbasaur",
                           "jp": "フシギダネ"
                       },
                       "sprites": {
                           "regular": "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/1/regular.png",
                           "shiny": "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/sprites/1/shiny.png",
                           "gmax": null
                       },
                       "types": [
                           {
                               "name": "Plante",
                               "image": "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/types/plante.png"
                           },
                           {
                               "name": "Poison",
                               "image": "https://raw.githubusercontent.com/Yarkis01/TyraDex/images/types/poison.png"
                           }
                       ],
                       "talents": [
                           {
                               "name": "Engrais",
                               "tc": false
                           },
                           {
                               "name": "Chlorophylle",
                               "tc": true
                           }
                       ],
                       "stats": {
                           "hp": 45,
                           "atk": 49,
                           "def": 49,
                           "speAtk": 65,
                           "speDef": 65,
                           "vit": 45
                       },
                       "evolution": null,
                       "height": "7",
                       "weight": "69",
                       "eggGroups": null,
                       "sexe": null,
                       "catchRate": null,
                       "level100": null
                   }
               ]
               """.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
                 let response = HTTPURLResponse(
                     url: request.url!,
                     statusCode: 200,
                     httpVersion: nil,
                     headerFields: nil
                 )!
                 return (response, jsonData)
             }

             let dataSource = MockDataSource()

             let expectation = self.expectation(description: "Fetch Pokemon")

             dataSource.fetchPokemon()
                 .sink(receiveCompletion: { completion in
                     if case .failure(let error) = completion {
                         XCTFail("Expected success, but got error \(error)")
                     }
                 }, receiveValue: { pokemons in
                     XCTAssertEqual(pokemons.count, 1)
                     XCTAssertEqual(pokemons.first?.name, "Bulbizarre")
                     expectation.fulfill()
                 })
                 .store(in: &cancellables)

             wait(for: [expectation], timeout: 1.0)
         }
}
    
    

