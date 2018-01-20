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
    
    // MARK: - IBOutlets
    @IBOutlet weak var _reposTableView: UITableView!
    @IBOutlet weak var _activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - iVars
    var userName : String?
    var reposTableViewModel : GCUserReposTableViewModel? {
        didSet{
            _reposTableView.dataSource = self
            _reposTableView.delegate = self
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    
    func setup()  {
        self.addBackButton(withImage: #imageLiteral(resourceName: "back"))
        self.addRightNavigationButton(title: "Save", action: #selector(save))
        self.navigationItem.title = userName
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
    
    @objc func save()  {
        self.reposTableViewModel?.persistCurrentData()
        AlertView.showAlert(WithMessage: "\(userName) repos saved successfully")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - _reposTableView TableView Datasource
extension GCReposViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposTableViewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return reposTableViewModel?.cellForRow(tableView,atIndexPath:indexPath) ?? UITableViewCell()
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 3rd item from bottom
        guard let totalRows = reposTableViewModel?.numberOfRows(), totalRows > 0 else {return}
        let thirdItemFromBottomIndex = IndexPath(row: totalRows - 3, section: 0)
        let firstCheck = (_reposTableView.indexPathsForVisibleRows?.contains(thirdItemFromBottomIndex))!
        let secondCheck = !(reposTableViewModel?.isLoadingList)!
        let thirdCheck = !(reposTableViewModel?.reachedEndOfItems)!
        if firstCheck && secondCheck && thirdCheck {
                reposTableViewModel?.nextBatch()
                reposTableViewModel?.loadRepos {[weak self] in
                    self?._reposTableView.reloadData()
                    }.addObserver(_activityIndicatorView)
            }
        }
}

// MARK: - _reposTableView TableView Delegate
extension GCReposViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return reposTableViewModel?.heightOfRow(atIndexPath: indexPath) ?? 0
    }
}


