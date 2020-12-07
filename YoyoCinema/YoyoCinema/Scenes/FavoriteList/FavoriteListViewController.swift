//
//  FavoriteListViewController.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/4/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

class FavoriteListViewController: UIViewController {

    // MARK: - Properties
    var favoriteDataSource: FavoriteListDataSource?

    // MARK: - UIControls

    private let layout: UICollectionViewFlowLayout  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
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
           view.addSubview(collectionView)
           updateConstraints()
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite"
        showDefaultNavigationBar()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if GlobalVariables.FavoriteList.isEmpty {
           emptyState(emptyPlaceHolderType: .empty)
            collectionView.reloadData()
        } else {
            collectionView.restore()
            favoriteDataSource = FavoriteListDataSource(viewController: self)
            collectionView.delegate = favoriteDataSource
            collectionView.dataSource = favoriteDataSource
            collectionView.reloadData()
        }

        guard  Reachability.shared.isConnected else {
            emptyState(emptyPlaceHolderType: .noInternetConnection)
            return
        }
    }

   // MARK: - Auto layout

    private func updateConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension FavoriteListViewController: BaseViewModelOutput {
    func emptyState(emptyPlaceHolderType: EmptyPlaceHolderType) {
        DispatchQueue.main.async {
            self.favoriteDataSource = nil
            self.collectionView.restore()
            self.collectionView.setEmptyView(emptyPlaceHolderType: emptyPlaceHolderType)
        }
    }

}
extension FavoriteListViewController: MovieCellDelegate {
    func cellTapped(movie: Movie) {
        let movieDetailsVC = MovieDetailsBuilder.viewController(movie: movie)
        navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
    
    
    
    
}
