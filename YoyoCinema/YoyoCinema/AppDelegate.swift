//
//  AppDelegate.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/3/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        Reachability.shared.startNetworkReachabilityObserver()
        window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = YoyoTabBarBuilder.viewController()
        window?.makeKeyAndVisible()

        return true
    }
}
