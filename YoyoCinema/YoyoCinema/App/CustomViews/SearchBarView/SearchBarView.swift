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
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
         stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    // MARK: - Initializers
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    func setup() {
        self.addSubview(searchStackView)
        [searchTextField, searchButton].forEach{
            searchStackView.addArrangedSubview($0)
        }
        setConstraints()
    }

    // MARK: - AutoLayout
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            searchStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            searchStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            searchStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
    
    @objc func searchButtonTapped() {
        if let searchText = searchTextField.text, !searchText.isEmpty {
           NotificationCenter.default.post(name: Notifications.searchTapped.name, object: searchText)
        }
    }

   
}

