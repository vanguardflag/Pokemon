//
//  PokeCharacterListInteractor.swift
//  Pokemon
//
//  Created by Jalal Najafi on 10/02/2021.
//

import Foundation


protocol PokeCharacterListBussinesLogic {
    func fetchPokeCharacters(isNext: Bool)
    var canFetchMore: Bool{get}
}

class PokeCharacterListInteractor {
    
    //MARK: Properties
    private weak var presenter: PokeCharacterListPresentationLogic?
    private let service: PokeServiceProtocol
    private var nextURL: String?
    private var counter: Int = 0
    private var totalCount: Int = 0
    
    init(service: PokeServiceProtocol = PokeService(),presenter: PokeCharacterListPresentationLogic?) {
        self.service = service
        self.presenter = presenter
    }
}


extension PokeCharacterListInteractor: PokeCharacterListBussinesLogic {
   
    var canFetchMore: Bool {
        return counter < totalCount
    }
    
    
    func fetchPokeCharacters(isNext: Bool) {
        if isNext{
            guard let nextURL = nextURL, let url = URL(string: nextURL) else {
                self.presenter?.displayPokemonCharacters(with: .init(result: .failure(AppError.requestError)))
                return
            }
            getPokoCharacters(url)
        }else {
            guard let url = URL(string: APIConstant.firstPage) else {
                self.presenter?.displayPokemonCharacters(with: .init(result: .failure(AppError.requestError)))
                return
            }
            getPokoCharacters(url)
        }
    }
    
    private func getPokoCharacters(_ url: URL) {
        service.getPokeList(url: url) {[weak self] result in
            switch result {
            case .success(let response):
                self?.nextURL = response.next
                self?.totalCount = response.count
                self?.counter += response.results.count
                self?.getPokemons(characters: response.results)
            case .failure(let error):
                self?.presenter?.displayPokemonCharacters(with: .init(result: .failure(error)))
            }
        }
    }
    
    //MARK: LifeCycle
    func getPokemons(characters: [BaseModel]){
        service.getPokemon(models: characters) { [weak self] result in
            switch result{
            case .success(let response):
                self?.presenter?.displayPokemonCharacters(with: .init(result: .success(response)))
            case .failure(let error):
                self?.presenter?.displayPokemonCharacters(with: .init(result: .failure(error)))
            }
        }
    }
    
}

