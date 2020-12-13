//
//  RemoteMovieListRepositoryTest.swift
//  YoyoCinemaTests
//
//  Created by Mohamed Kelany on 12/13/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import XCTest
@testable import YoyoCinema

class RemoteMovieListRepositoryTest: XCTestCase {

    var stubMovies: MovieListRepositoryMock!
    
    override func setUp() {
        super.setUp()
        
        stubMovies = MovieListRepositoryMock()
    }
    
    override func tearDown() {
        stubMovies = nil
        super.tearDown()
    }
    
    func testFetchMovieList() {

        stubMovies.testMovieList(url: Endpoint.movieList(path: "now_playing", withPage: 1)) { (result) in
            switch result {
            case .success(let movieList):
                XCTAssertNotNil(movieList.results)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testFetchDiscoverList() {

        stubMovies.testDiscoverList(url: Endpoint.discoverList(withPage: 1)) { (result) in
            switch result {
            case .success(let movieList):
                XCTAssertNotNil(movieList.results)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    
    }
    
    func testFetchSearchList() {

        stubMovies.testSearchList(url: Endpoint.search(for: "A", withPage: 1)) { (result) in
            switch result {
            case .success(let movieList):
                XCTAssertNotNil(movieList.results)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }

}
