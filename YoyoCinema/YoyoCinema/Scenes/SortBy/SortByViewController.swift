//
//  SortByViewController.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/5/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import UIKit

class SortByViewController: UIViewController {

    // MARK: - Properties
    var sortedByKeyList: [String]?
    var sortedByValueList: [String]?

    // MARK: - UIControls
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Intializers
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - View lifecycle

    override func loadView() {
        super.loadView()
        title = "Sort By"
        showDefaultNavigationBar()
        view.backgroundColor = .white
        view.addSubview(tableView)
        updateConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setDataforSortByList()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        // Do any additional setup after loading the view.
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

    private func setDataforSortByList() {
        sortedByKeyList = ["popularity.asc", "popularity.desc", "release_date.asc", "release_date.desc", "vote_average.asc", "vote_average.desc"]
        sortedByValueList = ["Popularity Ascending", "Popularity Descending", "Release Date Ascending", "Release Date Descending", "Vote Average Ascending", "Vote Average Descending" ]
    }

}
extension SortByViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortedByKeyList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier: String = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)

        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: CellIdentifier)
        }
        if let sortList = sortedByValueList {
            cell?.textLabel?.text = sortList[indexPath.row]
        }

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let sortList = sortedByKeyList {
            let selectedSortByKey = sortList[indexPath.row]
            NotificationCenter.default.post(name: Notifications.sortByTapped.name, object: selectedSortByKey)
            dismissCurrentView()
        }

    }

}
