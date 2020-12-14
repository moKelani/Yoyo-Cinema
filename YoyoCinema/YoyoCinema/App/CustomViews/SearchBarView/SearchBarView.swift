//
//  SearchBarView.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/6/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

class SearchBarView: UIView {

    // MARK: - UIControls
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "search here..."
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.search
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    func setup() {
        self.addSubview(searchTextField)
        searchTextField.delegate = self
        setConstraints()
    }

    // MARK: - AutoLayout
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            searchTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}

extension SearchBarView: UITextFieldDelegate {
    //UITextField delegate method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let searchText = searchTextField.text, !searchText.isEmpty {
            NotificationCenter.default.post(name: Notifications.searchTapped.name, object: searchText)
            self.endEditing(true)
            return true
        }
        return false
    }
}
