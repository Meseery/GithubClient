//
//  CellRepresentable.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/19/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import UIKit

protocol CellRepresentable {
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

