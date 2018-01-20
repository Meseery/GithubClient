//
//  ResourceExtensions.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/19/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import UIKit
import Siesta

extension UIActivityIndicatorView : ResourceObserver {
    public func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        switch event {
        case .newData, .error, .notModified, .requestCancelled:
            self.stopAnimating()
        case .requested, .observerAdded:
            self.startAnimating()
        }
    }
}

extension UIButton : ResourceObserver {
    public func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        switch event {
        case .newData, .error, .notModified, .requestCancelled:
            self.isHidden = false
        case .requested, .observerAdded:
            self.isHidden = true
        }
    }
}


