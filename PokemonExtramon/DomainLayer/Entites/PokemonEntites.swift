//
//  PokemonEntites.swift
//  PokemonExtramon
//
//  Created by Lion on 12/03/2024.
//

import Foundation
import SwiftUI


// Entites Used by use case

struct PokemonEntities: Identifiable{
    let id: Int
    let generation: Int?
    let category: String?
    let name : String
    let stats: PokemonStats
    let type: [TypeEntites]
    let talentsEntites: [TalentEntites]
    let sprite: SpriteEntites?
    let evolution: EvolutionEntites
    let height: String?
    let weight: String?
    let eggGroups: [String]?
    let sexe: SexeEntites?
    let catchRate: Int?
    let level100: Int?
    var color: Color {
        guard let type = type.first?.name?.capitalized else {
            return Color.gray
        }

        switch type {
        case "Plante":
            return Color.green
        case "Feu":
            return Color.red
        case "Eau":
            return Color.blue
        case "Glace":
            return Color.blue.opacity(0.5)
        case "Électrique":
            return Color.yellow
        case "Psy":
            return Color.purple
        case "Roche":
            return Color.brown
        case "Sol":
            return Color.orange
        case "Insecte":
            return Color.green.opacity(0.8)
        case "Poison":
            return Color.purple.opacity(0.8)
        case "Vol":
            return Color.blue.opacity(0.3)
        case "Combat":
            return Color.red.opacity(0.7)
        case "Spectre":
            return Color.indigo
        case "Dragon":
            return Color.orange.opacity(0.7)
        case "Normal":
            return Color.gray.opacity(0.8)
        case "Fée":
            return Color.pink
        default:
            return Color.gray
        }

        }
}

struct SpriteEntites {
    let regular : String?
    let shiny : String?
}

struct TypeEntites {
    
    let name : String?
    let image : String?
    
}



struct EvolutionEntites {
    let pre: [PreEvolutionEntites]?
    let next: [NextEvolutionEntites]?
    let mega: [SpriteMegaEntites]?
}


struct SpriteMegaEntites {
    let orbre : String?
    let regular: String?
    let shiny: String?
    
}

struct NextEvolutionEntites {
    let pokedexId: Int?
    let name: String?
    let condition: String?
}


struct TalentEntites  {
    let name: String?
    let tc: Bool?
}

struct SexeEntites: Codable {
    let male: Double?
    let female: Double?
}


struct PreEvolutionEntites: Codable {
    let pokedexId: Int?
    let name: String?
    let condition: String?
}


struct PokemonStats {
    let hp: Int?
    let attack: Int?
    let defense: Int?
    let spttack: Int?
    let spdefense: Int?
    let speed: Int?
    
}
