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
    let itemsPerBatch = 15
    var offset = 1
    var reachedEndOfItems : Bool{
        return userRepos.count == 100 // Assumption 
    }
    var isLoadingList : Bool = false
    
    private var dataProvider = _GCDataProvider()
    
    init(username:String) {
        self.username = username
        super.init()
    }
    
    func loadRepos(onCompletion: @escaping ()-> Void) -> Resource  {
        self.isLoadingList = true
        return dataProvider.fetchUserRepos(withUsername: username,
                                           page: offset,
                                           count: itemsPerBatch)
        {[weak self] (userRepos) in
            self?.isLoadingList = false
            self?.userRepos.append(contentsOf: userRepos)
            onCompletion()
        }
    }
    
    func persistCurrentData()  {
        let currentRepos = self.userRepos
        dataProvider.cacheRepos(forUser: username, repos: currentRepos)
    }
    
    func nextBatch(){
        offset += 1
    }
    
    func numberOfRows() -> Int {
        return self.userRepos.count
    }
    
    func heightOfRow(atIndexPath indexPath:IndexPath) -> CGFloat {
        return CGFloat(rowHeight)
    }
    
    func cellForRow(_ tableView:UITableView, atIndexPath indexPath:IndexPath) -> UITableViewCell {
        let repoCellViewModel = GCUserRepoViewModel(userRepo: userRepos[indexPath.row])
        
        return repoCellViewModel.cellInstance(tableView,
                                              indexPath: indexPath)
    }
    
}


