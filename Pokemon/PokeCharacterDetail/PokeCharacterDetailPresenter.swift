//
//  PokeCharacterDetailPresenter.swift
//  Pokemon
//
//  Created by Jalal Najafi on 11/02/2021.
//

import Foundation


//MARK: Protocols
protocol PokeCharacterDetailViewToPresenterProtocol: AnyObject {
    var view: PokeCharacterDetailDisplayLogic? { get set }
    var interactor: PokeCharacterDetailListBussinesLogic? { get set }
    
    func fetchPokeCharacter() -> (name: String, image: URL?, features: [FeatureSection])
}


class PokeCharacterDetailPresenter: PokeCharacterDetailViewToPresenterProtocol {

    
    var view: PokeCharacterDetailDisplayLogic?
    var interactor: PokeCharacterDetailListBussinesLogic?

    
    func fetchPokeCharacter() -> (name: String, image: URL?, features: [FeatureSection]){
        guard let pokemon = interactor?.pokemonCharacter else {
            return (name: "", image: nil, features: [])
        }
        return transform(pokemon: pokemon)
    }
    
    func transform(pokemon: PokemonViewModel) ->  (name: String, image: URL?, features: [FeatureSection]){
        var pokemonFeature: [FeatureSection] = []
        
        pokemonFeature.append(FeatureSection(title: TitleFeature.characteristic,
                                            features: [PokemonFeatureModel(name: "Name", value: pokemon.pokemonDetail.name),
                                                      PokemonFeatureModel(name: "base experience", value: "\( pokemon.pokemonDetail.baseExperience ?? 0)"),
                                                      PokemonFeatureModel(name: "height", value: "\(pokemon.pokemonDetail.height ?? 0)"),
                                                      PokemonFeatureModel(name: "order", value: "\( pokemon.pokemonDetail.order ?? 0)"),PokemonFeatureModel(name: "weight", value:  "\(pokemon.pokemonDetail.weight ?? 0)")]))
        
        
        pokemonFeature.append(FeatureSection(title: TitleFeature.abilities, features: pokemon.pokemonDetail.abilities.map({ pokemon -> PokemonFeatureModel in
            return PokemonFeatureModel(name: "ability Name", value: "\(pokemon?.ability?.name ?? "") is hidden: \( pokemon?.isHidden ?? true)" )
        })))
        
        pokemonFeature.append(FeatureSection(title: TitleFeature.gameIndices, features: pokemon.pokemonDetail.gameIndices.map({ game -> PokemonFeatureModel in
            return PokemonFeatureModel(name: "game version name", value: game?.version?.name)
        })))
        
        
        pokemonFeature.append(FeatureSection(title: TitleFeature.heldItems, features: pokemon.pokemonDetail.heldItems.map({ held -> PokemonFeatureModel in
            return PokemonFeatureModel(name: "held name", value: held?.item?.name)
        })))
        
        pokemonFeature.append(FeatureSection(title: TitleFeature.moves, features: pokemon.pokemonDetail.moves.map({ move -> PokemonFeatureModel in
            return PokemonFeatureModel(name: "move ", value: move?.move?.name)
        })))
    
        
        pokemonFeature.append(FeatureSection(title: TitleFeature.stats, features: pokemon.pokemonDetail.stats.map({ state -> PokemonFeatureModel in
            return PokemonFeatureModel(name: "stat ", value: "\(state?.stat?.name ?? ""), base_stat:  \(state?.base_stat ?? 0)  ,effort:  \(state?.effort ?? 0)" )
        })))
        
        pokemonFeature.append(FeatureSection(title: TitleFeature.types, features: pokemon.pokemonDetail.types.map({ type -> PokemonFeatureModel in
            return PokemonFeatureModel(name: "type ", value: type?.type?.name)
        })))
        
        let url = URL(string: pokemon.pokemonDetail.sprites?.frontDefault ?? "")
        return (pokemon.pokemonName, url, pokemonFeature)
    }
    

}
