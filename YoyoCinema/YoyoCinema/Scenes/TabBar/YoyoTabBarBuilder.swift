//
//  YoyoTabBarBuilder.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/4/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

class YoyoTabBarBuilder {

    static func viewController() -> YoyoTabBarController {

        let viewController: YoyoTabBarController = YoyoTabBarController()

        let homeVC = HomeBuilder.viewController()

        homeVC.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(named: "home_icon"), selectedImage: UIImage(named: "home_icon"))

        let favoriteVC = FavoriteListBuilder.viewController()
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "favorite_tabbar_icon"), selectedImage: UIImage(named: "favorite_tabbar_icon"))

        let searchVC = SearchBuilder.viewController()
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search_icon"), selectedImage: UIImage(named: "search_icon"))

        let discoverVC = DiscoverListBuilder.viewController()
        discoverVC.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(named: "discover_icon"), selectedImage: UIImage(named: "discover_icon"))

        let tabBarList = [
        UINavigationController(rootViewController: homeVC),
        UINavigationController(rootViewController: discoverVC),
        UINavigationController(rootViewController: searchVC),
        UINavigationController(rootViewController: favoriteVC)
        ]

        tabBarList.forEach { navigationController in
            navigationController.interactivePopGestureRecognizer?.delegate = nil
        }

        viewController.viewControllers = tabBarList
        return viewController
    }
}
