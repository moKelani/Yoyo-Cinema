//
//  MovieListRepositoryTest.swift
//  YoyoCinemaTests
//
//  Created by Mohamed Kelany on 12/12/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import XCTest
@testable import YoyoCinema

class MovieListRepositoryTest: XCTestCase {
    
    var stubMovies: MovieListRepositoryMock!
    let promise = XCTestExpectation(description: "Fetch Movies Completed")
    
    
    override func setUp() {
        super.setUp()
        
        stubMovies = MovieListRepositoryMock()
    }
    
    override func tearDown() {
        stubMovies = nil
        super.tearDown()
    }
    
    func testFetchMovieList() {
        
        var responseError: Error?
        var responseMovies: [Movie]?
        
        guard let bundle = Bundle.unitTest.path(forResource: "stub", ofType: "json") else {
            XCTFail("Failed to read content")
            return
        }
        
        stubMovies.testMovieList(url: URL(fileURLWithPath: bundle)) { (result) in
            switch result {
            case .success(let movieList):
                responseMovies = movieList.results
            case .failure(let error):
                responseError = error
            }
            self.promise.fulfill()
        }
        
        wait(for: [promise], timeout: 1)
        
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseMovies)
    }
    
    func testFetchDiscoverList() {
        
        var responseError: Error?
        var responseMovies: [Movie]?
        
        guard let bundle = Bundle.unitTest.path(forResource: "stub", ofType: "json") else {
            XCTFail("Failed to read content")
            return
        }
        
        stubMovies.testDiscoverList(url: URL(fileURLWithPath: bundle)) { (result) in
            switch result {
            case .success(let movieList):
                responseMovies = movieList.results
            case .failure(let error):
                responseError = error
            }
            self.promise.fulfill()
        }
        
        wait(for: [promise], timeout: 1)
        
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseMovies)
    }
    
    func testFetchSearchList() {
        
        var responseError: Error?
        var responseMovies: [Movie]?
        
        guard let bundle = Bundle.unitTest.path(forResource: "stub", ofType: "json") else {
            XCTFail("Failed to read content")
            return
        }
        
        stubMovies.testSearchList(url: URL(fileURLWithPath: bundle)) { (result) in
            switch result {
            case .success(let movieList):
                responseMovies = movieList.results
            case .failure(let error):
                responseError = error
            }
            self.promise.fulfill()
        }
        
        wait(for: [promise], timeout: 1)
        
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseMovies)
    }
}
