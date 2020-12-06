//
//  UICollectionView+EmptyState.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/3/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

extension UICollectionView {

    func setEmptyView(emptyPlaceHolderType: EmptyPlaceHolderType) {
        let frame = CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height)
        let emptyPlaceHolderView = EmptyPlaceHolderView(frame: frame)
        emptyPlaceHolderView.translatesAutoresizingMaskIntoConstraints = false
        emptyPlaceHolderView.emptyPlaceHolderType = emptyPlaceHolderType
        backgroundView = emptyPlaceHolderView
        NSLayoutConstraint.activate([
            emptyPlaceHolderView.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyPlaceHolderView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func restore() {
        backgroundView = nil
    }
}

extension UITableView {

    func setEmptyView(emptyPlaceHolderType: EmptyPlaceHolderType) {
        let frame = CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height)
        let emptyPlaceHolderView = EmptyPlaceHolderView(frame: frame)
        emptyPlaceHolderView.translatesAutoresizingMaskIntoConstraints = false
        emptyPlaceHolderView.emptyPlaceHolderType = emptyPlaceHolderType
        backgroundView = emptyPlaceHolderView
        NSLayoutConstraint.activate([
            emptyPlaceHolderView.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyPlaceHolderView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func restore() {
        backgroundView = nil
    }
}
