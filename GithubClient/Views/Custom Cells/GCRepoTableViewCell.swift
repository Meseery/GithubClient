//
//  GCRepoTableViewCell.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/19/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import UIKit

class GCRepoCell: UITableViewCell, GCCell {
    
    @IBOutlet weak var issueLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var repoName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(withViewModel vm: GCUserRepoViewModel) {
        self.repoName.text = vm.repoNameLabelText
        self.createdAtLabel.text = vm.repoCreatedAtLabelText
        self.issueLabel.text = vm.repoIssuesLabelText
    }    
}
