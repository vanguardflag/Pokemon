//
//  PokeCharacterList.swift
//  Pokemon
//
//  Created by Jalal Najafi on 10/02/2021.
//

import Foundation


enum FetchPokeCharacterList {
    public struct Response{
        var result: Result<[PokemonViewModel], Error>
    }
    
    public enum PresentResponse{
        case content([PokemonViewModel])
        case empty
        case error(Error)
    }
}
