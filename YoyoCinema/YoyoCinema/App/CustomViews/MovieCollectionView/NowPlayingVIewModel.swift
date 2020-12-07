//
//  NowPlayingVIewModel.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/4/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import Foundation

protocol NowPlayingViewModelInput: AnyObject {
   func getNowPlayingList(path: String)

}

protocol NowPlayingViewModelOutput: BaseMovieViewModelOutput {
    func gotoMovieDetails(movie: Movie)
}

class NowPlayingViewModel: NowPlayingViewModelInput {

    func getNowPlayingList(path: String) {
        getData(path: path, movieListRepository: self.movieListRepository)
    }

    weak var viewModelOutput: NowPlayingViewModelOutput?
    // input
    private var movieListRepository: MovieListRepository!

    init(movieListRepository: MovieListRepository = MovieListRepository(), view: NowPlayingViewModelOutput?) {
        self.movieListRepository = movieListRepository
        self.viewModelOutput = view
    }
}

// MARK: Setup

extension NowPlayingViewModel {

    private func getData(path: String, movieListRepository: MovieListRepository) {
        self.movieListRepository = movieListRepository
        movieListRepository.movieList(path: path, with: 1) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let movieList):
              self.viewModelOutput?.updateData(itemsForCollection: ItemsCollection.createItemsForCollection(movieList: movieList.results))

            case .failure(let error):
                print(error)
            }
        }

    }

}

extension NowPlayingViewModel: MovieCellDelegate {
    func cellTapped(movie: Movie) {
        viewModelOutput?.gotoMovieDetails(movie: movie)
    }
    
}
