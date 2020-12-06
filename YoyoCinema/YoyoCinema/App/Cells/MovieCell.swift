//
//  MovieCell.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/3/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell, CellReusable {

    var movie: Movie?
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingAverageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieImageView.isUserInteractionEnabled = true
        let tap: UITapGestureRecognizer = .init(target: self, action: #selector(imageTapped(_:)))
        movieImageView.addGestureRecognizer(tap)
    }
    
    func configCell(movie: Movie) {
        
        self.movie = movie
        
        if let path = movie.poster_path, let url = URL(string: "https://image.tmdb.org/t/p/w440_and_h660_face" + path) {
            movieImageView.kf.setImage(with: url)
        }
       
        if let vote = movie.vote_average {
           ratingAverageLabel.text = "\(vote)%"
        }
        
        releaseDateLabel.text = movie.release_date
        titleLabel.text = movie.title
    }
    
    @objc
    func imageTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        if let movie = movie {
            let movieDetailsVC = MovieDetailsBuilder.viewController(movie: movie)
            self.parentViewController?.navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
    }

}
