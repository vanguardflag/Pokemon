//
//  PokeCharacterListPresenter.swift
//  Pokemon
//
//  Created by Jalal Najafi on 10/02/2021.
//

import Foundation
import UIKit

//MARK: Protocols
protocol PokeCharacterListPresentationLogic: AnyObject {
    func displayPokemonCharacters(with presentResult: FetchPokeCharacterList.Response)
}

protocol PokeCharacterListViewToPresenterProtocol: AnyObject {
    var view: PokeCharacterListDisplayLogic? { get set }
    var interactor: PokeCharacterListBussinesLogic? { get set }
    var router: PokeCharacterListRouterProtocol? {get set}
    func canLoadMore()-> Bool
    func fetchPokeCharacters(isNext: Bool)
    func navigateToDetail(charcter: PokemonViewModel)
}




//MARK: - Implementation
class PokeCharacterListPresenter: PokeCharacterListViewToPresenterProtocol {
    weak var view: PokeCharacterListDisplayLogic?
    var interactor: PokeCharacterListBussinesLogic?
    var router: PokeCharacterListRouterProtocol?

    func fetchPokeCharacters(isNext: Bool) {
        interactor?.fetchPokeCharacters(isNext: isNext)
    }
    
    func canLoadMore() -> Bool {
        guard let interactor = interactor else {
            return false
        }
        return interactor.canFetchMore
    }
    
    func navigateToDetail(charcter: PokemonViewModel){
        guard let viewController = view as? UIViewController else {
            return
        }
        router?.navigateToDetail(from: viewController, for: charcter)
    }
}


extension PokeCharacterListPresenter: PokeCharacterListPresentationLogic {
    func displayPokemonCharacters(with presentResult: FetchPokeCharacterList.Response) {
        switch presentResult.result {
        case .success(let response):
            if response.isEmpty{
                view?.displayPokeCharatersList(result: .empty)
            }else{
                view?.displayPokeCharatersList(result: .content(response))
            }
        case .failure(_): break
            
        }
    }
}
