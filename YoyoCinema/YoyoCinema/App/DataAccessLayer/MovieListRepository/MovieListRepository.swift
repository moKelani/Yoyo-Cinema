//
//  MovieRepository.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/3/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//


class MovieListRepository {

    let client: MovieServiceAPI
    init(client: MovieServiceAPI = MovieServiceAPI()) {
        self.client =  client
    }

    func movieList(path: String, with page: Int, completion: @escaping (Result<MovieList, APIServiceError>) -> Void) {
        client.loadData(.movieList(path: path, withPage: page)) { (result: Result<MovieList, APIServiceError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
    
    func discoverList(sortby: String? = nil, withPage page: Int, completion: @escaping (Result<MovieList, APIServiceError>) -> Void) {
        client.loadData(.discoverList(sortby: sortby, withPage: page)) { (result: Result<MovieList, APIServiceError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
    
    func searchList(query: String, withPage page: Int, completion: @escaping (Result<MovieList, APIServiceError>) -> Void) {
        client.loadData(.search(for: query, withPage: page)) { (result: Result<MovieList, APIServiceError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }


}
