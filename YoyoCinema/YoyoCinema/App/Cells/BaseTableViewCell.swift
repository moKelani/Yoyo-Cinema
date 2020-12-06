//
//  BaseTableViewCell.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/4/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell, CellReusable {

    private lazy var moviesCollectionView: MovieCollectionView = {
        let moviesView = MovieCollectionView(frame: .zero)
        moviesView.translatesAutoresizingMaskIntoConstraints = false
        return moviesView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    func configCell(type: MovieCellType) {
       setConstraints()
        moviesCollectionView.updateCellType(movieCellType: type)
    }

    func setConstraints() {
        contentView.addSubview(moviesCollectionView)
        NSLayoutConstraint.activate([
            moviesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            moviesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moviesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            moviesCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }

}
