//
//  SearchListViewModel.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/4/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import Foundation

protocol SearchListViewModelInput: AnyObject {
    func searchList(query: String)
    func paginateMore(_ indexPath: IndexPath, dataSourceCount: Int)
}

protocol SearchListViewModelOutput: AnyObject, BaseViewModelOutput {
}

class SearchListViewModel: SearchListViewModelInput {

    weak var viewModelOutput: MovieListViewModelOutput?
    // input
    private var movieListRepository: MovieListRepository!

    private var currentPage = 1
    private var totalResults = 1
    private var query = ""

    init(movieListRepository: MovieListRepository = MovieListRepository()) {
        self.movieListRepository = movieListRepository
    }

    func searchList(query: String) {
        self.query = query
      getData(query: query, page: 1, movieListRepository: movieListRepository)
    }

    func paginateMore(_ indexPath: IndexPath, dataSourceCount: Int) {
        if indexPath.row + 1 == dataSourceCount && dataSourceCount < totalResults {
      loadMore(query: query, page: currentPage+1, movieListRepository: self.movieListRepository)
        }
    }

}

// MARK: Setup

extension SearchListViewModel {

    private func getData(query: String, page: Int, movieListRepository: MovieListRepository) {
           self.movieListRepository = movieListRepository

           guard  Reachability.shared.isConnected else {
               self.viewModelOutput?.emptyState(emptyPlaceHolderType: .noInternetConnection)
               return
           }
           viewModelOutput?.showLoading()
            movieListRepository.searchList(query: query, withPage: page) { [weak self] result in
               guard let self = self else {return}
               self.viewModelOutput?.hideLoading()
               switch result {
               case .success(let movieList):
                 self.viewModelOutput?.updateData(itemsForCollection: self.createItemsForTable(movieList: movieList.results))
                 self.totalResults = movieList.totalResults

               case .failure(let error):
                   print(error)
                   self.viewModelOutput?.emptyState(emptyPlaceHolderType: .error(message: error.localizedDescription))
               }
           }
       }

    private func loadMore(query: String, page: Int, movieListRepository: MovieListRepository) {
           self.movieListRepository = movieListRepository

           viewModelOutput?.showLoading()
        movieListRepository.searchList(query: query, withPage: page) { [weak self] result in
               guard let self = self else {return}
               self.viewModelOutput?.hideLoading()
               switch result {
               case .success(let movieList):
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

extension SearchListViewModel: MovieCellDelegate {
    func cellTapped(movie: Movie) {
        viewModelOutput?.gotoMovieDetails(movie: movie)
    }

}
