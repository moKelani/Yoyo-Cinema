//
//  MovieDetailsViewController.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/5/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    // MARK: - Properties
    var movieDetailsViewModelInput: MovieDetailsViewModelInput

     // MARK: - UIControls

    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        return scroll
    }()

    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let movieReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "YoyoGrayColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let movieRateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "RateRedColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let movieOverViewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(named: "YoyoGrayColor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "image_placeholder_icon"))
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "image_placeholder_icon"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var favoriteImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "unfavorite_btn_icon"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var baseInfoStackView: UIStackView = {
           let stackView = UIStackView()
           stackView.axis = .vertical
            stackView.distribution = .fill
           stackView.alignment = .fill
           stackView.spacing = 8
           stackView.translatesAutoresizingMaskIntoConstraints = false
           return stackView
       }()

     // MARK: - Intializers
    init(withViewModel viewModel: MovieDetailsViewModel) {
        self.movieDetailsViewModelInput = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        [bannerImageView, movieImageView, baseInfoStackView, movieOverViewLabel].forEach {
            scrollView.addSubview($0)
        }

        [movieTitleLabel, movieReleaseDateLabel, movieRateLabel].forEach {
            baseInfoStackView.addArrangedSubview($0)
        }
        updateConstraints()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showDefaultNavigationBar()
       // updateRighBarButton(isFavourite: isFavourited)
        movieDetailsViewModelInput.getMovieDetails()

    }

     // MARK: - AutoLayout
    private func updateConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            bannerImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: 280.0)
        ])

        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: -100),
            movieImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            movieImageView.widthAnchor.constraint(equalToConstant: 100),
            movieImageView.heightAnchor.constraint(equalToConstant: 200)
        ])

        NSLayoutConstraint.activate([
            baseInfoStackView.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 16),
            baseInfoStackView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 8),
            baseInfoStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            movieOverViewLabel.topAnchor.constraint(equalTo: baseInfoStackView.bottomAnchor, constant: 16),
            movieOverViewLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            movieOverViewLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            movieOverViewLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50)

        ])

    }
     // MARK: - Methods
    var isFavourited = false
    func updateRighBarButton(isFavourite: Bool) {
        let btnFavourite = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btnFavourite.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)

        if isFavourite {
            btnFavourite.setImage(UIImage(named: "selected_Favorite_icon"), for: .normal)
        } else {
            btnFavourite.setImage(UIImage(named: "favorite_icon"), for: .normal)
        }

        let rightButton = UIBarButtonItem(customView: btnFavourite)
        rightNavBarItems(rightButton)
    }

    @objc
    func favoriteTapped() {
        isFavourited = !isFavourited
        movieDetailsViewModelInput.updateMovieDetails(isFavorite: isFavourited)
        self.updateRighBarButton(isFavourite: isFavourited)
    }

}
 // MARK: - setup
extension MovieDetailsViewController: MovieDetailsViewModelOutput {
    func updateData(movie: Movie) {

        if let path = movie.backdrop_path, let url = URL(string: GlobalVariables.backDropBaseURL + path) {
            bannerImageView.kf.setImage(with: url)
        }

        if let path = movie.poster_path, let url = URL(string: GlobalVariables.posterBaseURL + path) {
            movieImageView.kf.setImage(with: url)
        }

        movieTitleLabel.text = movie.title ?? ""
        movieReleaseDateLabel.text = movie.release_date ?? ""
        movieRateLabel.text = "\(movie.vote_average ?? 0.0)"
        movieOverViewLabel.text = movie.overview ?? ""
        updateRighBarButton(isFavourite: false)
        for value in GlobalVariables.FavoriteList where movie.id == value.id {
            isFavourited = true
            updateRighBarButton(isFavourite: true)
        }

    }

    func emptyState(emptyPlaceHolderType: EmptyPlaceHolderType) {
       // resultCollectionView.setEmptyView(emptyPlaceHolderType: emptyPlaceHolderType)
    }

}
