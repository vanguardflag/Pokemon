//
//  PokeCharacterListRouter.swift
//  Pokemon
//
//  Created by Jalal Najafi on 11/02/2021.
//

import Foundation
import UIKit

protocol PokeCharacterListRouterProtocol {
    func navigateToDetail(from viewController: UIViewController, for pokemon: PokemonViewModel)
}


class PokeCharacterListRouter: PokeCharacterListRouterProtocol{
    
    func navigateToDetail(from viewController: UIViewController, for pokemon: PokemonViewModel) {
        let detailViewController = PokeCharacterDetailBuilder().setPokemonCharacter(pokemon).build()
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
}
