//
//  BaseMovieViewModelOutput.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/7/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import Foundation

protocol BaseMovieViewModelOutput: AnyObject {
    func updateData(itemsForCollection: [ItemCollectionViewCellType])
}
