//
//  UICollectionView+ReusableCell.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/3/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: CellReusable>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError(
              "Failed to dequeue a cell with identifier \(T.identifier) matching type \(T.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                + "and that you registered the cell beforehand"
            )
        }
        return cell
    }
}
