//
//  DiscoverListViewModel.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/5/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import Foundation

protocol DiscoverListViewModelInput: AnyObject {
    func discoverList(sortby: String)
    func paginateMore(_ indexPath: IndexPath, dataSourceCount: Int)
}

class DiscoverListViewModel: DiscoverListViewModelInput {

    weak var viewModelOutput: MovieListViewModelOutput?
    // input
    private var movieListRepository: MovieListRepository!

    private var currentPage = 1
    private var totalResults = 1
    private var sortby = ""

    init(movieListRepository: MovieListRepository = MovieListRepository()) {
        self.movieListRepository = movieListRepository
    }

    func discoverList(sortby: String) {
        self.sortby = sortby
        getData(sortby: sortby, page: 1, movieListRepository: self.movieListRepository)

    }

    func paginateMore(_ indexPath: IndexPath, dataSourceCount: Int) {
        if indexPath.row + 1 == dataSourceCount && dataSourceCount < totalResults {
            loadMore(sortby: sortby, page: currentPage+1, movieListRepository: self.movieListRepository)
        }
    }

}

extension DiscoverListViewModel {
    private func getData(sortby: String, page: Int, movieListRepository: MovieListRepository) {
           self.movieListRepository = movieListRepository

           guard  Reachability.shared.isConnected else {
               self.viewModelOutput?.emptyState(emptyPlaceHolderType: .noInternetConnection)
               return
           }
           viewModelOutput?.showLoading()
        movieListRepository.discoverList(sortby: sortby, withPage: page) { [weak self] result in
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

    private func loadMore(sortby: String, page: Int, movieListRepository: MovieListRepository) {
           self.movieListRepository = movieListRepository

           viewModelOutput?.showLoading()
        movieListRepository.discoverList(sortby: sortby, withPage: page) { [weak self] result in
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
