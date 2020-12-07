//
//  MovieCollectionViewDataSource.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/3/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

enum ItemCollectionViewCellType {
    case cellItem(movie: Movie)
}

class MovieCollectionViewDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var itemsForCollection: [ItemCollectionViewCellType]

    weak var movieListViewModelInput: MovieListViewModelInput?
    weak var discoverListViewModelInput: DiscoverListViewModelInput?
    weak var searchListViewModelInput: SearchListViewModelInput?

    init(itemsForCollection: [ItemCollectionViewCellType], viewModel: MovieListViewModelInput) {
        self.itemsForCollection = itemsForCollection
        movieListViewModelInput = viewModel
    }

    init(itemsForCollection: [ItemCollectionViewCellType], viewModel: DiscoverListViewModelInput) {
        self.itemsForCollection = itemsForCollection
        discoverListViewModelInput = viewModel
    }

    init(itemsForCollection: [ItemCollectionViewCellType], viewModel: SearchListViewModelInput) {
        self.itemsForCollection = itemsForCollection
        searchListViewModelInput = viewModel
    }

    // MARK: - Table view data source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsForCollection.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = itemsForCollection[indexPath.row]
        switch item {
        case .cellItem(let movie):
            let cell: MovieCell? = collectionView.dequeueReusableCell(for: indexPath)
            cell?.configCell(movie: movie)
            if let viewModel = movieListViewModelInput as? MovieListViewModel {
               cell?.delegate = viewModel
            }
            if let viewModel = discoverListViewModelInput as? DiscoverListViewModel {
               cell?.delegate = viewModel
            }
            if let viewModel = searchListViewModelInput as? SearchListViewModel {
               cell?.delegate = viewModel
            }
            
            return cell ?? UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                 willDisplay cell: UICollectionViewCell,
                   forItemAt indexPath: IndexPath) {

        movieListViewModelInput?.paginateMore(indexPath, dataSourceCount: itemsForCollection.count)
        discoverListViewModelInput?.paginateMore(indexPath, dataSourceCount: itemsForCollection.count)
        searchListViewModelInput?.paginateMore(indexPath, dataSourceCount: itemsForCollection.count)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellWidth = (collectionView.frame.size.width - 50)/2

        return CGSize(width: cellWidth, height: cellWidth*1.75)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
