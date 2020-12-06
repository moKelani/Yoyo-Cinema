//
//  NowPlayingDataSource.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/4/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

enum HomeCollectionViewType {
    case cellItem(item: ItemCollectionViewCellType)
    case moreItem
}

class NowPlayingDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var itemsForCollection: [HomeCollectionViewType]

    init(itemsForCollection: [HomeCollectionViewType]) {
        self.itemsForCollection = itemsForCollection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsForCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let item = itemsForCollection[indexPath.row]
       let cell: BaseCell? = collectionView.dequeueReusableCell(for: indexPath)
        switch item {
        case .cellItem(.cellItem(movie: let movie)):
            cell?.configCell(movie: movie)
            return cell ?? UICollectionViewCell()
        case .moreItem:
            return cell ?? UICollectionViewCell()
        }
    }
 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 240)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 20, bottom: 20, right: 5)
    }
    
    
}

