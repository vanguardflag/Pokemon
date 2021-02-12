//
//  PokemonCharacterListPresenterMock.swift
//  PokemonTests
//
//  Created by Jalal Najafi on 12/02/2021.
//

import Foundation
 
@testable import Pokemon

class PokeCharacterListPresenterMock:PokeCharacterListPresentationLogic{
    private(set) var hasCallDisplay:Bool = false
    
    func displayPokemonCharacters(with presentResult: FetchPokeCharacterList.Response) {
        hasCallDisplay = true
    }  
    
}
