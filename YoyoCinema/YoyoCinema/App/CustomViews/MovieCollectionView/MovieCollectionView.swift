//
//  MovieCollectionView.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/4/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

class MovieCollectionView: UIView {

    // MARK: - Properties
    var nowPlayingDataSource: NowPlayingDataSource?
    var nowPlayingViewModelInput: NowPlayingViewModelInput?

    var movieCellType: MovieCellType = .nowPlaying

    private var path = ""

    // MARK: - UIControls
    private let layout: UICollectionViewFlowLayout  = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()

    private lazy var nowPlayingCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(BaseCell.self, forCellWithReuseIdentifier: BaseCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

     // MARK: - Intializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        self.addSubview(nowPlayingCollectionView)
        setConstraints()
        nowPlayingViewModelInput = NowPlayingViewModel(view: self)

    }

    func updateCellType(movieCellType: MovieCellType) {
        self.movieCellType = movieCellType
        path = movieCellType == .nowPlaying ? "now_playing" : "upcoming"
        nowPlayingViewModelInput?.getNowPlayingList(path: path)
    }

    // MARK: - AutoLayout
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nowPlayingCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            nowPlayingCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            nowPlayingCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            nowPlayingCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
extension MovieCollectionView: NowPlayingViewModelOutput {

    func gotoMovieDetails(movie: Movie) {
        let movieDetailsVC = MovieDetailsBuilder.viewController(movie: movie)
        findViewController()?.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
    
    func updateData(itemsForCollection: [ItemCollectionViewCellType]) {
        if let viewModel = nowPlayingViewModelInput {
            nowPlayingDataSource = NowPlayingDataSource(itemsForCollection: itemsForCollection, viewModel: viewModel)
        }

        DispatchQueue.main.async {
            self.nowPlayingCollectionView.delegate = self.nowPlayingDataSource
            self.nowPlayingCollectionView.dataSource = self.nowPlayingDataSource
            self.nowPlayingCollectionView.reloadData()
        }
    }
}
