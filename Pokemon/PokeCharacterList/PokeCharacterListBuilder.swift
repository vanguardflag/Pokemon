//
//  PokeCharacterListBuilder.swift
//  Pokemon
//
//  Created by Jalal Najafi on 10/02/2021.
//

import Foundation
import UIKit

public class PokeCharacterListBuilder: ModuleBuilder{
    public init() {}

    func build() -> some UIViewController {
        let presenter = PokeCharacterListPresenter()
        let interactor = PokeCharacterListInteractor(presenter: presenter)
        let viewController = PokeCharacterListViewController(presenter: presenter)
        let router = PokeCharacterListRouter()
        presenter.interactor = interactor
        presenter.view = viewController
        presenter.router = router
        return viewController
    }
}
