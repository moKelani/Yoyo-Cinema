//
//  UIViewController+NavigationBar.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/5/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideLargeTitleNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func showLargeTitleNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    // you can use that function for setting navigation bar items in the top right of navigation bar
    func rightNavBarItems(_ buttons: UIBarButtonItem...) {
        navigationItem.rightBarButtonItems = buttons
    }
    
    // you can use that function for setting navigation bar items in the top left of navigation bar
    func leftNavBarItems(_ buttons: UIBarButtonItem...) {
        navigationItem.leftBarButtonItems = buttons
    }
    

    
    func hideNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    func prepareNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
    }
    
    func showLargeNavigationBar() {
        prepareNavigationBar()
        navigationController?.navigationBar.largeTitleTextAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)]
        showLargeTitleNavigationBar()
    }

    func showDefaultNavigationBar() {
        prepareNavigationBar()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)]
        hideLargeTitleNavigationBar()
        
    }
    
    func showNotClearNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray,
                                                                   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)]
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.isNavigationBarHidden = false
        let image = UIImage(named: "whiteBg")
        navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    

    @objc func dismissCurrentView() {
        dismiss(animated: true, completion: nil)
    }

}



