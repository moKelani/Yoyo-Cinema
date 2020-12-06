//
//  BaseCell.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/4/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell, CellReusable  {
    
    var movie: Movie?
    
    lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFill
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
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = true
        
    }
    
    @objc
    func imageTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        if let movie = movie {
            let movieDetailsVC = MovieDetailsBuilder.viewController(movie: movie)
            self.parentViewController?.navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
    }
    
    func configCell(movie: Movie) {
        self.movie = movie
        
        if let path = movie.poster_path, let url = URL(string: "https://image.tmdb.org/t/p/w440_and_h660_face" + path) {
            thumbnailImageView.kf.setImage(with: url)
        }
        
        setupConstraints()
    }
    
    private func setupViews() {
        contentView.addSubview(thumbnailImageView)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

        ])
    }
}
