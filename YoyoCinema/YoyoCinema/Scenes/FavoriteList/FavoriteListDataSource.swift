//
//  FavoriteListDataSource.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/4/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

class FavoriteListDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var viewController: FavoriteListViewController?
    
    init(viewController: FavoriteListViewController) {
        self.viewController = viewController
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        GlobalVariables.FavoriteList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FavoriteCell? = collectionView.dequeueReusableCell(for: indexPath)
        cell?.configCell(movie: GlobalVariables.FavoriteList[indexPath.row])
        cell?.delegate = viewController
        return cell ?? UICollectionViewCell()
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
