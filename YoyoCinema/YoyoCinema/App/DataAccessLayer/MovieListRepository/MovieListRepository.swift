//
//  MovieRepository.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/3/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//
import Foundation

class MovieListRepository {

    let client: APIService
    init(client: APIService = APIService()) {
        self.client =  client
    }

    func movieList(path: String, with page: Int, completion: @escaping (Result<MovieList, APIError>) -> Void) {
        
        client.loadData(from: Endpoint.movieList(path: path, withPage: page)) { (result: Result<MovieList, APIError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }

    func discoverList(sortby: String? = nil, withPage page: Int, completion: @escaping (Result<MovieList, APIError>) -> Void) {
        client.loadData(from: Endpoint.discoverList(sortby: sortby, withPage: page)) { (result: Result<MovieList, APIError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }

    func searchList(query: String, withPage page: Int, completion: @escaping (Result<MovieList, APIError>) -> Void) {
        client.loadData(from: Endpoint.search(for: query, withPage: page)) { (result: Result<MovieList, APIError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }

}
