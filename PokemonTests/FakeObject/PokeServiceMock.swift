//
//  PokeServiceMock.swift
//  PokemonTests
//
//  Created by Jalal Najafi on 12/02/2021.
//

import Foundation
@testable import Pokemon

class PokeServiceMock: PokeServiceProtocol {
    private var result:Result<PokeListResultModel, Error>
    private var resultURL:Result<[PokemonViewModel], Error>
    
    init(result: Result<PokeListResultModel, Error>,resultURL: Result<[PokemonViewModel], Error>) {
        self.result = result
        self.resultURL = resultURL
    }
    
    func getPokeList(url: URL, then handler: @escaping (Result<PokeListResultModel, Error>) -> Void) {
        handler(result)
    }
    
    func getPokemon(models: [BaseModel], then handler: @escaping (Result<[PokemonViewModel], Error>) -> Void) {
        handler(resultURL)
    }
    
    func configure(result: Result<PokeListResultModel, Error>){
        self.result = result
    }
    
    func configure(resultURL: Result<[PokemonViewModel], Error>){
        self.resultURL = resultURL
    }
}
