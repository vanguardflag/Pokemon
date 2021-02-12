//
//  PokeCharacterDetail.swift
//  Pokemon
//
//  Created by Jalal Najafi on 11/02/2021.
//

import Foundation

enum FetchPokeCharacterDetail {
    public struct Response{
        var result: Result<[PokemonViewModel], Error>
    }
    
    public enum PresentResponse{
        case content(PokemonViewModel)
        case empty
        case error(Error)
    }
}
