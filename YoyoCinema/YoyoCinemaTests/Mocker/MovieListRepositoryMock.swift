//
//  MovieListRepositoryMock.swift
//  YoyoCinemaTests
//
//  Created by Mohamed Kelany on 12/13/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import Foundation
@testable import YoyoCinema

class MovieListRepositoryMock {
    
    let client: APIService
    init(client: APIService = APIService()) {
        self.client =  client
    }
    
    func testMovieList( url: URL,completion: @escaping (Result<MovieList, APIError>) -> Void) {
        client.loadData(from: url) { (result: Result<MovieList, APIError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func testDiscoverList( url: URL,completion: @escaping (Result<MovieList, APIError>) -> Void) {
        client.loadData(from: url) { (result: Result<MovieList, APIError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }

    func testSearchList( url: URL,completion: @escaping (Result<MovieList, APIError>) -> Void) {
        client.loadData(from: url) { (result: Result<MovieList, APIError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }

}

