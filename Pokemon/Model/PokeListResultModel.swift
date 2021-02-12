//
//  PokeListResultModel.swift
//  Pokemon
//
//  Created by Jalal Najafi on 09/02/2021.
//

import Foundation


struct PokeListResultModel: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [BaseModel]
}


struct BaseModel: Decodable {
    let name: String?
    let url: String?
}



