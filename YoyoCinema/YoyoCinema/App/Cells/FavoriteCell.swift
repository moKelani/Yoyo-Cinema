//
//  FavoriteCell.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/6/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

class FavoriteCell: BaseCell {

    lazy var favoriteImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "favorite_btn_icon"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.kf.cancelDownloadTask()
        thumbnailImageView.image = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    override func configCell(movie: Movie) {
        super.configCell(movie: movie)
        setupConstraints()
    }

    private func setupViews() {
        contentView.addSubview(favoriteImageView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            favoriteImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            favoriteImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 40),
            favoriteImageView.widthAnchor.constraint(equalToConstant: 40)

        ])
    }
}
