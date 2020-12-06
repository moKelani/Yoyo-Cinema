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
    let total_pages: Int
    let total_results: Int
}

struct Movie: Codable {
    let poster_path: String?
    let backdrop_path: String?
    let overview: String?
    let release_date: String?
    let genre_ids: [Int]?
    let id: Int?
    let original_title: String?
    let original_language: String?
    let title: String?
    let vote_count: Int?
    let vote_average: Float?
    var isFavorite: Bool? = false
}
