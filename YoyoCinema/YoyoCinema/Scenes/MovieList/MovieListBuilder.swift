//
//  MovieListBuilder.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/3/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

struct MovieListBuilder {

    static func viewController(listType: Int) -> UIViewController {
        let viewModel = MovieListViewModel()
        let viewController: MovieListViewController = MovieListViewController(withViewModel: viewModel)
        viewController.movieListViewModelInput = viewModel
        viewController.listType = listType
        viewModel.viewModelOutput = viewController

        return viewController
    }

}
