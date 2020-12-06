//
//  MovieListViewModel.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/3/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import Foundation

protocol MovieListViewModelInput: AnyObject {
    func getMovieList(with index: Int)
    func paginateMore(_ indexPath: IndexPath, dataSourceCount: Int)
}

protocol MovieListViewModelOutput: AnyObject, BaseViewModelOutput {
    func updateData(itemsForCollection: [ItemCollectionViewCellType])
    func updateCollectionView(itemsForCollection: [ItemCollectionViewCellType])
    func emptyState(emptyPlaceHolderType: EmptyPlaceHolderType)
}

class MovieListViewModel: MovieListViewModelInput {

    weak var viewModelOutput: MovieListViewModelOutput?
    // input
    private var movieListRepository: MovieListRepository!

    private var currentPage = 1
    private var totalResults = 1
    private var currentPath = "now_playing"

    init(movieListRepository: MovieListRepository = MovieListRepository()) {
        self.movieListRepository = movieListRepository
    }

    func getMovieList(with index: Int) {
       currentPath = index == 0 ? "now_playing" : "upcoming"
       getData(path: currentPath, page: 1, movieListRepository: self.movieListRepository)

    }

    func paginateMore(_ indexPath: IndexPath, dataSourceCount: Int) {
        if indexPath.row + 1 == dataSourceCount && dataSourceCount < totalResults {
            loadMore(page: currentPage+1, movieListRepository: self.movieListRepository)
        }
    }
}

// MARK: Setup

extension MovieListViewModel {

    private func getData(path: String, page: Int, movieListRepository: MovieListRepository) {
        self.movieListRepository = movieListRepository

        guard  Reachability.shared.isConnected else {
            self.viewModelOutput?.emptyState(emptyPlaceHolderType: .noInternetConnection)
            return
        }
        viewModelOutput?.showLoading()
        movieListRepository.movieList(path: path, with: page) { [weak self] result in
            guard let self = self else {return}
            self.viewModelOutput?.hideLoading()
            switch result {
            case .success(let movieList):
              print(movieList)
              self.viewModelOutput?.updateData(itemsForCollection: self.createItemsForTable(movieList: movieList.results))
              self.totalResults = movieList.total_results

            case .failure(let error):
                print(error)
                self.viewModelOutput?.emptyState(emptyPlaceHolderType: .error(message: error.localizedDescription))
            }
        }
    }

    private func loadMore(page: Int, movieListRepository: MovieListRepository) {
        self.movieListRepository = movieListRepository

        viewModelOutput?.showLoading()
        movieListRepository.movieList(path: currentPath, with: page) { [weak self] result in
            guard let self = self else {return}
            self.viewModelOutput?.hideLoading()
            switch result {
            case .success(let movieList):
              print(movieList)
              self.viewModelOutput?.updateCollectionView(itemsForCollection: self.createItemsForTable(movieList: movieList.results))

            case .failure(let error):
                print(error)
                self.viewModelOutput?.emptyState(emptyPlaceHolderType: .error(message: error.localizedDescription))
            }
        }
    }

    private func createItemsForTable(movieList: [Movie]) -> [ItemCollectionViewCellType] {
        let itemsForTable: [ItemCollectionViewCellType] = movieList.map { movie -> ItemCollectionViewCellType in
            return ItemCollectionViewCellType.cellItem(movie: movie)
        }
        return itemsForTable
    }
}