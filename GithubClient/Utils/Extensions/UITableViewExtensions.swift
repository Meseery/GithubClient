//
//  UITableViewExtensions.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/20/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import UIKit

extension UITableView {
    func setEmptyMessage(_ message: String) {
        guard self.numberOfRows() == 0 else {
            return
        }
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.medium)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    public func numberOfRows() -> Int {
        var section = 0
        var rowCount = 0
        while section < numberOfSections {
            rowCount += numberOfRows(inSection: section)
            section += 1
        }
        return rowCount
    }
}
