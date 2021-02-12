//
//  Pokemon.swift
//  Pokemon
//
//  Created by Jalal Najafi on 10/02/2021.
//

import Foundation
import UIKit

struct PokemonModel: Decodable {
    let abilities: [AbilitiesModel?]
    let baseExperience: Int?
    let forms: [BaseModel?]
    let gameIndices: [GameIndiceModel?]
    let height: Int?
    let heldItems: [HeldItemModel?]
    let id: Int
    let isDefault: Bool?
    let locationAreaEncounters: String?
    let moves: [MovesModel?]
    let name: String?
    let order: Int?
    let species: BaseModel?
    let sprites: SpritesModel?
    let stats: [statsModel?]
    let types: [TypesModel?]
    let weight: Int?
    
    enum CodingKeys: String, CodingKey{
        case isDefault = "is_default"
        case heldItems = "held_items"
        case gameIndices = "game_indices"
        case baseExperience = "base_experience"
        case locationAreaEncounters = "location_area_encounters"
        case abilities, forms, height, id, moves, name,order, species, sprites, stats, types, weight
    }
}

struct TypesModel: Decodable {
    let slot: Int?
    let type: BaseModel?
}

struct statsModel: Decodable {
    let base_stat: Int?
    let effort: Int?
    let stat: BaseModel?
}


struct SpritesModel: Decodable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    
    enum CodingKeys: String, CodingKey{
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}

struct MovesModel: Decodable {
    let move: BaseModel?
    let versionGroupDetails: [VersionGroupDetailsModel?]
    
    enum CodingKeys: String, CodingKey{
        case move
        case versionGroupDetails = "version_group_details"
    }
}

struct VersionGroupDetailsModel: Decodable {
    let levelLearnedAt: Int?
    let moveLearnMethod: BaseModel?
    let versionGroup: BaseModel?
    
    enum CodingKeys: String, CodingKey {
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
        case levelLearnedAt = "levelLearned_at"
    }
}

struct HeldItemModel: Decodable{
    let item: BaseModel?
    let versionDetails: [versionDetailsModel]
    
    enum CodingKeys: String, CodingKey {
        case versionDetails = "version_details"
        case item
    }
}

struct versionDetailsModel: Decodable {
    let rarity: Int?
    let version: BaseModel?
}

struct GameIndiceModel: Decodable {
    let gameIndex: Int?
    let version: BaseModel?
    
    enum CodingKeys: String, CodingKey {
        case version
        case gameIndex = "game_index"
    }
}

struct AbilitiesModel: Decodable {
    let ability: BaseModel?
    let isHidden: Bool?
    let slot: Int?
    
    enum CodingKeys: String, CodingKey {
        case ability, slot
        case isHidden = "is_hidden"
    }
}
