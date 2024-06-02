//
//  PokemonEntityTest.swift
//  PokemonExtramon
//
//  Created by Lion on 23/05/2024.
//

import XCTest
@testable import PokemonExtramon

class PokemonEntitiesTests: XCTestCase {

    func testPokemonEntityInit() {
        
        let pokemon = PokemonEntities(id: 1,generation: 1,category: "Herbe", name: "Bulbizarre", stats:  PokemonStats(hp: 45, attack: 49, defense: 49, spttack: 65, spdefense: 65, speed: 45), type: [TypeEntites(name: "Plante", image: nil)], talentsEntites: [TalentEntites(name: "Pulpe", tc: true)],sprite: SpriteEntites(regular: "https://example.com", shiny: nil), evolution: EvolutionEntites(pre: nil, next: nil, mega: nil), height: "0.7m", weight: "6.9kg", eggGroups: nil, sexe: nil, catchRate: nil, level100: nil)
    
        XCTAssertEqual(pokemon.name, "Bulbizarre")

    }
  

}
