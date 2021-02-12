//
//  PokemonFeatureModel.swift
//  Pokemon
//
//  Created by Jalal Najafi on 11/02/2021.
//

import Foundation

public struct FeatureSection: Hashable {
    let title: TitleFeature
    let features: [PokemonFeatureModel]
}

struct PokemonFeatureModel: Hashable {
    let name: String
    let value: String?
    init(name: String,value: String?) {
        self.name = name
        self.value = value
    }
}


enum TitleFeature: String {
    case abilities = "abilities"
    case characteristic = "characteristic"
    case gameIndices = "game Indices"
    case heldItems = "held items"
    case moves = "moves"
    case species = "species"
    case stats = "stats"
    case types = "types"
}



