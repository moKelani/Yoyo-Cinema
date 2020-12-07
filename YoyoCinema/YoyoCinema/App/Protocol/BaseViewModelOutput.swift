//
//  BaseViewModelOutput.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/3/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

protocol BaseViewModelOutput {
    func showLoading()
    func hideLoading()
    func emptyState(emptyPlaceHolderType: EmptyPlaceHolderType)
}

extension BaseViewModelOutput where Self: UIViewController {
    func showLoading() {
        DispatchQueue.main.async {
            self.view.startActivityIndicator()
        }

    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.view.stopActivityIndicator(tag: 55)
        }
    }
}
