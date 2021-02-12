//
//  PokeCharacterDetailInteractor.swift
//  Pokemon
//
//  Created by Jalal Najafi on 11/02/2021.
//

import Foundation


protocol PokeCharacterDetailListBussinesLogic {
    var pokemonCharacter: PokemonViewModel?{get set}
}


class PokeCharacterDetailInteractor: PokeCharacterDetailListBussinesLogic {
    //MARK: Properties
    private var pokemon:PokemonViewModel?
    

    var pokemonCharacter: PokemonViewModel?{
        get {
            return self.pokemon
        }
        set{
            pokemon = newValue
        }
    }
}
