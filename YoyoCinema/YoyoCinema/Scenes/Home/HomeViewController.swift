//
//  HomeViewController.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/4/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    var homeDataSource: HomeDataSource?
    
    // MARK: - UIControls
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(BaseTableViewCell.self, forCellReuseIdentifier: BaseTableViewCell.identifier)
        tableView.register(MovieTableViewHeader.self, forHeaderFooterViewReuseIdentifier: MovieTableViewHeader.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Intializers
    init() {
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    
    // MARK: - View lifecycle

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(tableView)
        updateConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Yoyo Cimena"
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
        homeDataSource = HomeDataSource()
        tableView.delegate = homeDataSource
        tableView.dataSource = homeDataSource
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard  Reachability.shared.isConnected else {
            homeDataSource = nil
            tableView.restore()
            emptyState(emptyPlaceHolderType: .noInternetConnection)
            return
        }
    }
    
    // MARK: - AutoLayout
    private func updateConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
       
        
    }

   
}

extension HomeViewController: BaseViewModelOutput {
    func emptyState(emptyPlaceHolderType: EmptyPlaceHolderType) {
        DispatchQueue.main.async {
            self.homeDataSource = nil
            self.tableView.restore()
            self.tableView.setEmptyView(emptyPlaceHolderType: emptyPlaceHolderType)
        }
    }
    
    
}


