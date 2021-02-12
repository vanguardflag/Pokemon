//
//  PokeCharactersDataSource.swift
//  Pokemon
//
//  Created by Jalal Najafi on 10/02/2021.
//

import Foundation
import UIKit


class PokeCharactersDataSource: NSObject, UICollectionViewDataSource {
    private var pokemonViewModel: [PokemonViewModel] = []
    private var pokemonViewModelSearch: [PokemonViewModel] = []

    func searchBy(name: String) -> [PokemonViewModel]{
        if name.isEmpty{
            return pokemonViewModelSearch
        }
        return pokemonViewModelSearch.filter({ poke -> Bool in
            return poke.pokemonName.lowercased().contains(name.lowercased())
        })
    }
    
    func getCharacter(for index: Int) -> PokemonViewModel?{
        return pokemonViewModel[index]
    }
    
    func configure(characters: [PokemonViewModel]){
        self.pokemonViewModel.append(contentsOf: characters)
        self.pokemonViewModelSearch = pokemonViewModel
    }
    
    func configureSearch(characters: [PokemonViewModel]){
        self.pokemonViewModel = characters
    }
    
    func reset(){
        self.pokemonViewModel.removeAll()
        pokemonViewModelSearch.removeAll()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PokeCharacterListCell.identifier,
            for: indexPath
        ) as? PokeCharacterListCell else {
            return UICollectionViewCell()
        }
        let url =  pokemonViewModel[indexPath.row].pokemonDetail.sprites?.frontDefault ?? ""
        
        cell.configureCell(with: URL(string: url),
                           name: pokemonViewModel[indexPath.row].pokemonName)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
