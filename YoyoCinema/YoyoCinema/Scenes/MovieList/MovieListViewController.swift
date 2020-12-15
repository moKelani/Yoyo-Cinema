//
//  ViewController.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/3/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    // MARK: - Properties
    var movieListViewModelInput: MovieListViewModelInput?
    var discoverListViewModelInput: DiscoverListViewModelInput?
    var searchListViewModelInput: SearchListViewModelInput?
    var movieCollectionViewDataSource: MovieCollectionViewDataSource?

    var listType: Int?
    var observation: Any?
    var searchObservation: Any?

    // MARK: - UIControls
    private let layout: UICollectionViewFlowLayout  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    lazy var searchBarView: SearchBarView = {
        let search = SearchBarView()
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()

    private var movieListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
         stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Intializers

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(withViewModel viewModel: MovieListViewModel) {
        self.movieListViewModelInput = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    init(withViewModel viewModel: DiscoverListViewModel) {
        self.discoverListViewModelInput = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    init(withViewModel viewModel: SearchListViewModel) {
        self.searchListViewModelInput = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        if let observation = observation {
            NotificationCenter.default.removeObserver(observation)
        }
        if let observation = searchObservation {
            NotificationCenter.default.removeObserver(observation)
        }
        movieCollectionViewDataSource = nil
    }

    // MARK: - View lifecycle

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(movieListStackView)
        movieListStackView.addArrangedSubview(collectionView)
        updateConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        showDefaultNavigationBar()

        
        if let type = listType {
           self.collectionView.restore()
           movieListViewModelInput?.getMovieList(with: type)
        }

        if let viewModel = discoverListViewModelInput {
            rightNavBarItems(sortButton())
            title = "Discover"
            self.collectionView.restore()
            viewModel.discoverList(sortby: "")
            
            observation = NotificationCenter.default.addObserver(forName: Notifications.sortByTapped.name, object: nil, queue: nil) { [weak self] result in
                if let sort = result.object as? String {
                    self?.discoverListViewModelInput?.discoverList(sortby: sort)
                }
            }
        }

        if let viewModel = searchListViewModelInput {
            movieListStackView.removeArrangedSubview(collectionView)
            [searchBarView, collectionView].forEach {
                movieListStackView.addArrangedSubview($0)
            }
            title = "Search"
            emptyState(emptyPlaceHolderType: .search)

            searchObservation = NotificationCenter.default.addObserver(forName: Notifications.searchTapped.name, object: nil, queue: nil) { [weak self] result in
                if let searchText = result.object as? String, !searchText.isEmpty {
                    self?.collectionView.restore()
                    viewModel.searchList(query: searchText)
                } else {
                    self?.movieCollectionViewDataSource = nil
                    self?.collectionView.reloadData()
                    self?.collectionView.restore()
                    self?.emptyState(emptyPlaceHolderType: .search)
                }
            }
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        movieCollectionViewDataSource = nil
    }

    // MARK: - Auto layout

    private func updateConstraints() {
        NSLayoutConstraint.activate([
            movieListStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieListStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieListStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieListStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    // MARK: - Methods Methods
    @objc func sortButton() -> UIBarButtonItem {
        let barButtonItem =  UIBarButtonItem()
        barButtonItem.image = UIImage(named: "sort_icon")
        barButtonItem.tintColor = .black
        barButtonItem.action = #selector(sortTapped)
        barButtonItem.target = self
        return barButtonItem
    }

    @objc func sortTapped() {
        self.navigationController?.present(UINavigationController(rootViewController: SortByViewController()), animated: true)
    }
}
// MARK: - setup
extension MovieListViewController: MovieListViewModelOutput {
    
    func gotoMovieDetails(movie: Movie) {
        let movieDetailsVC = MovieDetailsBuilder.viewController(movie: movie)
        navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
    
    func updateData(itemsForCollection: [ItemCollectionViewCellType]) {
        if let viewModel = movieListViewModelInput {
            print("movieListViewModelInput", movieListViewModelInput)
          movieCollectionViewDataSource = MovieCollectionViewDataSource(itemsForCollection: itemsForCollection, viewModel: viewModel)
        }
        if let viewModel = discoverListViewModelInput {
            print("discoverListViewModelInput", discoverListViewModelInput)
          movieCollectionViewDataSource = MovieCollectionViewDataSource(itemsForCollection: itemsForCollection, viewModel: viewModel)
        }

        if let viewModel = searchListViewModelInput {
            print("searchListViewModelInput", searchListViewModelInput)
          movieCollectionViewDataSource = MovieCollectionViewDataSource(itemsForCollection: itemsForCollection, viewModel: viewModel)
        }

        DispatchQueue.main.async {
            self.collectionView.delegate = self.movieCollectionViewDataSource
            self.collectionView.dataSource = self.movieCollectionViewDataSource
            self.collectionView.reloadData()
        }
    }

    func updateCollectionView(itemsForCollection: [ItemCollectionViewCellType]) {
        movieCollectionViewDataSource?.itemsForCollection.append(contentsOf: itemsForCollection)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    func emptyState(emptyPlaceHolderType: EmptyPlaceHolderType) {
        DispatchQueue.main.async {
            self.collectionView.restore()
            self.collectionView.setEmptyView(emptyPlaceHolderType: emptyPlaceHolderType)
        }
    }

}
