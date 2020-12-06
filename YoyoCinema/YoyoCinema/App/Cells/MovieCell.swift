//
//  MovieCell.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/3/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: BaseCell {

    let movieReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "YoyoGrayColor")
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieRateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(named: "yellow_color")
        return label
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        movieRateLabel.layer.cornerRadius = 20.0
        movieRateLabel.layer.masksToBounds = true

    }
    
    private func setupViews() {
        [movieReleaseDateLabel, movieRateLabel, movieTitleLabel].forEach{
           contentView.addSubview($0)
        }
        

    }

    override func setupConstraints() {
        
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 210),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 140)
            
        ])
        
        NSLayoutConstraint.activate([
            movieRateLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor, constant: 5),
            movieRateLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: -20),
            movieRateLabel.heightAnchor.constraint(equalToConstant: 40),
            movieRateLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            movieTitleLabel.topAnchor.constraint(equalTo: movieRateLabel.bottomAnchor, constant: 5),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieRateLabel.leadingAnchor),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 21)
            
        ])
        
        NSLayoutConstraint.activate([
            movieReleaseDateLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor),
            movieReleaseDateLabel.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor),
            movieReleaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieReleaseDateLabel.heightAnchor.constraint(equalToConstant: 21),
            movieReleaseDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    override func configCell(movie: Movie) {
        super.configCell(movie: movie)
        self.movie = movie

        if let vote = movie.vote_average {
           movieRateLabel.text = "\(vote)%"
        }

        movieReleaseDateLabel.text = movie.release_date
        movieTitleLabel.text = movie.title
    }
    
    


}
