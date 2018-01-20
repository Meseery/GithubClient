//
//  GCReposViewController.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/19/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import UIKit
import Siesta

class GCReposViewController: UIViewController {
    
    @IBOutlet weak var _reposTableView: UITableView! {
        didSet{
            _reposTableView.dataSource = self
            _reposTableView.delegate = self
        }
    }
    @IBOutlet weak var _activityIndicatorView: UIActivityIndicatorView!
    
    var userName : String?

    var reposTableViewModel : GCUserReposTableViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup()  {
        _reposTableView.tableFooterView = UIView()
        guard let username = userName else {
            AlertView.showAlert(WithMessage: "No such user")
            return
        }
        reposTableViewModel = GCUserReposTableViewModel(username: username)
        reposTableViewModel?.loadRepos {[weak self] in
            self?._reposTableView.reloadData()
        }.addObserver(_activityIndicatorView)
    }
    

}

// MARK: - _reposTableView TableView Datasource
extension GCReposViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return reposTableViewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == repos.count - 3 { // 3rd item from bottom
//
//        }
        
        return reposTableViewModel?.cellForRow(tableView,atIndexPath:indexPath) ?? UITableViewCell()
        
    }
}

// MARK: - _reposTableView TableView Delegate
extension GCReposViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return reposTableViewModel?.heightOfRow(atIndexPath: indexPath) ?? 0
    }
}


