//
//  BaseCell.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/4/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit
import Kingfisher

protocol MovieCellDelegate: class {
    func cellTapped(movie: Movie)
}

class BaseCell: UICollectionViewCell, CellReusable {

    var movie: Movie?

    weak var delegate: MovieCellDelegate?
    
    lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "image_placeholder_icon"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.kf.cancelDownloadTask()
        thumbnailImageView.image = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        let tap: UITapGestureRecognizer = .init(target: self, action: #selector(imageTapped(_:)))
        thumbnailImageView.addGestureRecognizer(tap)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.layer.cornerRadius = 10.0
        thumbnailImageView.layer.masksToBounds = true

    }

    @objc
    func imageTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        if let movie = movie {
            delegate?.cellTapped(movie: movie)
        }
    }

    func configCell(movie: Movie) {
        self.movie = movie

        if let path = movie.poster_path, let url = URL(string: GlobalVariables.posterBaseURL + path) {
            thumbnailImageView.kf.setImage(with: url)
        }

        setupConstraints()
    }

    private func setupViews() {
        contentView.addSubview(thumbnailImageView)

    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        ])
    }
}
