//
//  ItemsCollection.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/7/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import Foundation

class ItemsCollection {
    
    static func createItemsForCollection(movieList: [Movie]) -> [ItemCollectionViewCellType] {
        let itemsForTable: [ItemCollectionViewCellType] = movieList.map { movie -> ItemCollectionViewCellType in
            return ItemCollectionViewCellType.cellItem(movie: movie)
        }
        return itemsForTable
    }
}
