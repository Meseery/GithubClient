//
//  GCUserReposTableViewModel.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/19/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import UIKit
import Siesta

let rowHeight = 100.0


class GCUserReposTableViewModel: NSObject {
    
    var username : String
    var userRepos : [GCUserRepo] = []
    let itemsPerBatch = 50
    var offset = 0
    var reachedEndOfItems = false
    
    private var dataProvider = _GCDataProvider()
    
    init(username:String) {
        self.username = username
        super.init()
    }
    
    func loadRepos(onCompletion: @escaping ()-> Void) -> Resource  {
        return dataProvider.fetchUserRepos(withUsername: username,
                                           page: offset,
                                           count: itemsPerBatch)
        {[weak self] (userRepos) in
            self?.userRepos.append(contentsOf: userRepos)
            onCompletion()
        }
    }
    
    
    func numberOfRows() -> Int {
        return self.userRepos.count
    }
    
    func heightOfRow(atIndexPath indexPath:IndexPath) -> CGFloat {
        return 100.0
    }
    
    func cellForRow(_ tableView:UITableView, atIndexPath indexPath:IndexPath) -> UITableViewCell {
        let repoCellViewModel = GCUserRepoViewModel(userRepo: userRepos[indexPath.row])
        
        return repoCellViewModel.cellInstance(tableView: tableView,
                                              indexPath: indexPath)
    }
    
}


