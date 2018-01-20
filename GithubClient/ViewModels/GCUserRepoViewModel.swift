//
//  GCUserRepoViewModel.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/19/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import UIKit

class GCUserRepoViewModel: CellRepresentable {
    var repo: GCUserRepo
    
    var repoNameLabelText: String {
        guard let name = repo.name else {
            return ""
        }
        return name
    }
    
    var repoCreatedAtLabelText: String {
        guard let createdAt = repo.createdAt else {
            return ""
        }
        return "created at" + Date().displayTime(date: createdAt)
    }
    
    var repoIssuesLabelText : String  {
        guard let issuesCount = repo.openIssuesCount else {
            return "No Open Issues"
        }
        return String(issuesCount) + " open issues"
    }
    
    
    init(userRepo : GCUserRepo ) {
        self.repo = userRepo
    }
    
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: GCRepoCell.identifier, for: indexPath) as! GCRepoCell
        // Pass ourselves (the view model) to setup the cell
        cell.configureCell(withViewModel: self)
        
        // Return the cell
        return cell
    }
}
