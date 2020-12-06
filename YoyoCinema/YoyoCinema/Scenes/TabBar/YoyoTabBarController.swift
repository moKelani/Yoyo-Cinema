//
//  YoyoTabBarController.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/4/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

class YoyoTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.layer.borderWidth = 0.0
        tabBar.layer.borderColor = UIColor.clear.cgColor
        tabBar.clipsToBounds = true
         UITabBar.appearance().barTintColor = UIColor.white
         UITabBar.appearance().tintColor = UIColor(named: "yellow_color")
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }


}

