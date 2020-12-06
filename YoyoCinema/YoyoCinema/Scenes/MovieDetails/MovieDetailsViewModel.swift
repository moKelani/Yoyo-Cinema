//
//  MovieDetailsViewModel.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/5/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import Foundation

protocol MovieDetailsViewModelInput: AnyObject {
    func getMovieDetails()
    func updateMovieDetails(isFavorite: Bool)
}

protocol MovieDetailsViewModelOutput: AnyObject, BaseViewModelOutput {
    func updateData(movie: Movie)
}

class MovieDetailsViewModel: MovieDetailsViewModelInput {
    
    weak var viewModelOutput: MovieDetailsViewModelOutput?
    // input
    var movie: Movie!
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func getMovieDetails() {
        viewModelOutput?.updateData(movie: movie)
    }
    
    func updateMovieDetails(isFavorite: Bool) {
        movie.isFavorite = isFavorite
        if isFavorite {
            GlobalVariables.FavoriteList.append(movie)
            print(GlobalVariables.FavoriteList)
            
        } else {
                for (index, value) in GlobalVariables.FavoriteList.enumerated() where movie.id == value.id {
                    GlobalVariables.FavoriteList.remove(at: index)
                }
        }
    }
    
}
