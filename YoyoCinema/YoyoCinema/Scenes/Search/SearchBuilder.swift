//
//  SearchBuilder.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/4/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

struct SearchBuilder {

    static func viewController() -> UIViewController {
        let viewModel = SearchListViewModel()
        let viewController: MovieListViewController = MovieListViewController(withViewModel: viewModel)
        viewController.searchListViewModelInput = viewModel
        viewModel.viewModelOutput = viewController
        return viewController
    }

}
