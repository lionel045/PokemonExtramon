//
//  Pokemon.swift
//  PokemonExtramon
//
//  Created by Lion on 08/03/2024.
//

import Foundation
import SwiftUI


struct PokemonData : Codable, Identifiable {
    let id: UUID?
    let pokedexId: Int
    let generation: Int
    let category: String?
    let name: NameData
    let sprites: SpriteData?
    let types: [TypeData]?
    let talents: [TalentData]?
    let stats: StatsData?
    let resistances: [ResistanceData]?
    let evolution: EvolutionData?
    let height: String?
    let weight: String?
    let eggGroups: [String]?
    let sexe: SexeData?
    let catchRate: Int?
    let level100: Int?
    let formes: [Forme]? 
}

struct NameData: Codable {
    let fr: String
    let en: String
    let jp: String
}

struct SpriteData: Codable {
    let regular: String?
    let shiny: String?
    let gmax: gmaxValue?
}


struct gmaxValue: Codable {
    let regular: String?
    let shiny: String?
}

struct TypeData: Codable {
    let name: String?
    let image: String?
}

struct TalentData: Codable {
    let name: String?
    let tc: Bool?
}



struct StatsData: Codable {
    let hp: Int?
    let atk: Int?
    let def: Int?
    let speAtk: Int?
    let speDef: Int?
    let vit: Int?
    

}

struct ResistanceData: Codable {
    let name: String?
    let multiplier: Float?
}

struct EvolutionData: Codable {
    let pre: [PreEvolutionData]?
    let next: [NextEvolutionData]?
    let mega: [SpriteMega]?
}


struct SpriteMega: Codable {
    let orbre : String?
    let regular: String?
    let shiny: String?
    
}

struct PreEvolutionData: Codable {
    let pokedexId: Int?
    let name: String?
    let condition: String?
}

struct NextEvolutionData: Codable {
    let pokedexId: Int?
    let name: String?
    let condition: String?
}

struct SexeData: Codable {
    let male: Double?
    let female: Double?
}

struct Forme: Codable {
    let region: String
    let name: NamePokemon
}

struct NamePokemon: Codable {
    
    let fr: String
    let en: String
    let jp: String
    
}

extension PokemonData {
    // Map entity to model
    func toEntity() -> PokemonEntities {
        
        let typeEntities = self.types?.compactMap { TypeEntites(name: $0.name, image: $0.image) } ?? []
        
        let stats = PokemonStats(
            hp: self.stats?.hp,
            attack: self.stats?.atk,
            defense: self.stats?.def,
            spttack: self.stats?.speAtk,
            spdefense: self.stats?.speDef,
            speed: self.stats?.vit
        )
        
        // Mappez les évolutions
        let evolution = EvolutionEntites(
            pre: self.evolution?.pre?.map {
                PreEvolutionEntites(pokedexId: $0.pokedexId, name: $0.name, condition: $0.condition)
            },
            next: self.evolution?.next?.map {
                NextEvolutionEntites(pokedexId: $0.pokedexId, name: $0.name, condition: $0.condition)
            },
            mega: self.evolution?.mega?.map {
                SpriteMegaEntites(orbre: $0.orbre, regular: $0.regular, shiny: $0.shiny)
            }
        )
        
        
       let talentEntites = self.talents?.map { TalentEntites(name: $0.name, tc: $0.tc) } ?? []
        
        return PokemonEntities(
            id: self.pokedexId,
            generation: self.generation,
            category: self.category,
            name: self.name.fr,
            stats: stats,
            type: typeEntities,
            talentsEntites: talentEntites,
            sprite: SpriteEntites(regular: self.sprites?.regular, shiny: self.sprites?.shiny),
            evolution: evolution,
            height: self.height,
            weight: self.weight,
            eggGroups: self.eggGroups,
            sexe: SexeEntites(male: self.sexe?.male, female: self.sexe?.female),
            catchRate: self.catchRate,
            level100: self.level100
        )
    }
}

