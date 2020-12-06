//
//  UICollectionView+ReusableCell.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/3/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: CellReusable>(for indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T
    }
}
