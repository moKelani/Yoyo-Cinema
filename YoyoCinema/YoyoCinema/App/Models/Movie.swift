//
//  Movie.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/3/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import Foundation

struct MovieList: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Codable {
    let posterPath: String?
    let backdropPath: String?
    let overview: String?
    let releaseDate: String?
    let id: Int?
    let originalTitle: String?
    let originalLanguage: String?
    let title: String?
    let voteCount: Int?
    let voteAverage: Float?
    var isFavorite: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case isFavorite
        
    }
}
