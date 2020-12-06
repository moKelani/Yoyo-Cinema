//
//  MovieTableViewHeader.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/5/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit


class MovieTableViewHeader: UITableViewHeaderFooterView {

    static let identifier = "MovieTableViewHeader"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var viewAllbutton: UIButton = {
        let button = UIButton()
        button.setTitle("View All", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    
    private func setupViews() {
      contentView.backgroundColor = .white
      contentView.addSubview(titleLabel)
      contentView.addSubview(viewAllbutton)
        
        
    }
    
    private func setupConstraints() {
        setupViews()
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            viewAllbutton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            viewAllbutton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            viewAllbutton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    var listType = 0
    @objc func ontappedViewAllButton(sender: UIButton) {
       //NotificationCenter.default.post(name: notificationName, object: nil)
        let movieList = MovieListBuilder.viewController(listType: listType)
        self.parentViewController?.navigationController?.pushViewController(movieList, animated: true)
    }
    
    func configCell(title: String) {
        setupConstraints()
        viewAllbutton.addTarget(self, action: #selector(ontappedViewAllButton), for: .touchUpInside)
        titleLabel.text = title
        if title == "Up Coming" {
            listType = 1
        }
    }

    deinit {
        print("🐳🐳🐳🐳🐳 AdDetailsDescriptionHeader")
    }
}
