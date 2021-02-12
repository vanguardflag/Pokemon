//
//  PokeCharacterDetailBuilder.swift
//  Pokemon
//
//  Created by Jalal Najafi on 11/02/2021.
//

import Foundation
import UIKit

public class PokeCharacterDetailBuilder: ModuleBuilder{
    private var pokemon:PokemonViewModel?
    public init() {}
    
    @discardableResult
    public func setPokemonCharacter(_ pokemon: PokemonViewModel) -> Self {
        self.pokemon = pokemon
        return self
    }

    func build() -> some UIViewController {
        guard let pokemon = self.pokemon else {
            preconditionFailure("dependencies are not set")
        }
        let presenter = PokeCharacterDetailPresenter()
        let interactor = PokeCharacterDetailInteractor()
        interactor.pokemonCharacter = pokemon
        let viewController = PokeCharacterDetailViewController(presenter: presenter)
        presenter.interactor = interactor
        return viewController
    }
}
