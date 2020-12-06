//
//  MovieDetails.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/5/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

struct MovieDetailsBuilder {

    static func viewController(movie: Movie) -> UIViewController {
        let viewModel = MovieDetailsViewModel(movie: movie)
        let viewController: MovieDetailsViewController = MovieDetailsViewController(withViewModel: viewModel)
        viewController.movieDetailsViewModelInput = viewModel
        viewModel.viewModelOutput = viewController
        return viewController
    }


}

