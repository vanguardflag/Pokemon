//
//  ResponseModelTest.swift
//  PokemonTests
//
//  Created by Jalal Najafi on 12/02/2021.
//

import XCTest

@testable
import Pokemon

class ResponseModelTest: XCTestCase {
    
    private let bundle = Bundle(for: ResponseModelTest.self)
    
    override func setUpWithError() throws {
    }

    func testPhotolistResponse() {
        let jsonFileName = "pokemonlist"
        
        let sut: PokeListResultModel = bundle.decodeFile(name: jsonFileName)!
        
        XCTAssertTrue(sut.count == 1118)
        XCTAssertTrue(sut.next == "https://pokeapi.co/api/v2/pokemon/?offset=40&limit=20")
        XCTAssertTrue(sut.previous == "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20")
        XCTAssertTrue(sut.results.count == 20)
    }
    
    func testPhotolistEmpty() {
        let jsonFileName = "pokemonlistempty"
        
        let sut: PokeListResultModel = bundle.decodeFile(name: jsonFileName)!
        
        XCTAssert(sut.results.count == 0)
    }
    
    
    func testPhotolistResponseLastPage() {
        let jsonFileName = "pokemonlistlastpage"

        let sut: PokeListResultModel = bundle.decodeFile(name: jsonFileName)!

        XCTAssertNil(sut.next)
    }

    
    func testPhotoURLResponse() {
        let jsonFileName = "detailOfCharacter"

        let sut: PokemonModel = bundle.decodeFile(name: jsonFileName)!
        
        XCTAssertNotNil(sut.name)
        
        
    }
    
    

    
}


