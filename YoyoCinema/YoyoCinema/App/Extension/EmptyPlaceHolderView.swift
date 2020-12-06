//
//  EmptyPlaceHolderView.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/3/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

enum EmptyPlaceHolderType {
    case noInternetConnection
    case error(message: String)
    case search
    case empty

}

class EmptyPlaceHolderView: UIView {

    var emptyPlaceHolderType: EmptyPlaceHolderType = .noInternetConnection {
        didSet {
            switch emptyPlaceHolderType {
            case .noInternetConnection:
                titleLabel.text = "No internet connection"
                detailsLabel.text = "Please check your internet connection and try again."
                logoImageView.image = UIImage(named: "retry")
            case .error(let message):
                titleLabel.text = "Error Happen"
                detailsLabel.text = message
                logoImageView.image = UIImage(named: "retry")
            case .search:
                titleLabel.text = "Search"
                detailsLabel.text = "Enter Your Text"
                logoImageView.image = UIImage(named: "search_icon")
                logoImageView.tintColor = .black
            case .empty:
                titleLabel.text = "No Data Yet"
            }
        }
    }

    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = nil
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.widthAnchor.constraint(equalToConstant: 60)
        ])
        return imageView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(labelsStackView)
        return stackView
    }()

    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing =  0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(detailsLabel)
        stackView.addArrangedSubview(actionButton)
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let detailsLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .clear
        addSubview(contentStackView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
