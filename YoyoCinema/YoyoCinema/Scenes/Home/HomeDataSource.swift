//
//  HomeDataSource.swift
//  YoyoCinema
//
//  Created by Mohamed Kelany on 12/4/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

enum MovieCellType {
  case nowPlaying
  case upComing
}
import UIKit

class HomeDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    weak var viewController: HomeViewController?
    
    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BaseTableViewCell? = tableView.dequeueReusableCell(for: indexPath)
        switch indexPath.section {
        case 0:
            cell?.configCell(type: .nowPlaying)
        case 1:
            cell?.configCell(type: .upComing)
        default:
            break
        }

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView: MovieTableViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: MovieTableViewHeader.identifier) as? MovieTableViewHeader else {
            return nil
        }
        switch section {
        case 0:
            headerView.configCell(title: "Now Playing")
            headerView.delegate = viewController
            return headerView
        case 1:
            headerView.configCell(title: "Up Coming")
            headerView.delegate = viewController
            return headerView
        default:
            return UIView()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
           return 250
        } else {
           return 520
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //MovieListBuilder.viewController()
    }

}
