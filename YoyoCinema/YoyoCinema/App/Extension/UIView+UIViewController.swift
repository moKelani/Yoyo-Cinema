//
//  UIView+UIViewController.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/7/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit


extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
