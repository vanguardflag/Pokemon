//
//  PokemonCharacterListInteractorTest.swift
//  PokemonTests
//
//  Created by Jalal Najafi on 12/02/2021.
//

import XCTest

@testable
import Pokemon

class PokemonCharacterListInteractorTest: XCTestCase {
    private let bundle = Bundle(for: PokemonCharacterListInteractorTest.self)
    private var sut: PokeCharacterListInteractor!
    private var fakePresenter: PokeCharacterListPresenterMock!
    private var fakePokeService: PokeServiceMock!
    
    override func setUpWithError() throws {
        fakePokeService = PokeServiceMock(result: .failure(AppError.noData), resultURL: .failure(AppError.noData))
        fakePresenter = PokeCharacterListPresenterMock()
        sut = PokeCharacterListInteractor(service: fakePokeService, presenter: fakePresenter)
    }


    func testGetPhotosProblem() {
        
        sut.fetchPokeCharacters(isNext: false)
        XCTAssert(fakePresenter.hasCallDisplay)
    }

 
    func testGetPhotoWithData(){
        let sutData: PokeListResultModel = bundle.decodeFile(name: "pokemonlist")!
        fakePokeService.configure(result: .success(sutData))

        sut.fetchPokeCharacters(isNext: false)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            XCTAssert(self.fakePresenter.hasCallDisplay)
        }
    }

    func testGetPhotoWithError(){
        fakePokeService.configure(result: .failure(AppError.noData))

        sut.fetchPokeCharacters(isNext: true)

        XCTAssert(fakePresenter.hasCallDisplay)

    }
    
    func testGetPhotoWithEmpty(){
        let sutData: PokeListResultModel = bundle.decodeFile(name: "pokemonlistempty")!
        fakePokeService.configure(result: .success(sutData))

        sut.fetchPokeCharacters(isNext: false)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            XCTAssert(self.fakePresenter.hasCallDisplay)
        }

    }




 
}

