//
//  DiscoverListBuilder.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/5/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

struct DiscoverListBuilder {

    static func viewController() -> UIViewController {
        let viewModel = DiscoverListViewModel()
        let viewController: MovieListViewController = MovieListViewController(withViewModel: viewModel)
        viewController.discoverListViewModelInput = viewModel
        viewModel.viewModelOutput = viewController
        
        return viewController
    }

}
