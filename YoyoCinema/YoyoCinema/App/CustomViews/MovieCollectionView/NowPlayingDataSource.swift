//
//  NowPlayingDataSource.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/4/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit



class NowPlayingDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var itemsForCollection: [ItemCollectionViewCellType]
    var nowPlayingViewModelInput: NowPlayingViewModelInput?

    init(itemsForCollection: [ItemCollectionViewCellType], viewModel: NowPlayingViewModelInput) {
        self.itemsForCollection = itemsForCollection
        nowPlayingViewModelInput = viewModel
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsForCollection.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let item = itemsForCollection[indexPath.row]
       let cell: BaseCell? = collectionView.dequeueReusableCell(for: indexPath)
        switch item {
        case .cellItem(movie: let movie):
            cell?.configCell(movie: movie)
            if let viewModel = nowPlayingViewModelInput as? NowPlayingViewModel {
               cell?.delegate = viewModel
            }
            return cell ?? UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 240)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

}
