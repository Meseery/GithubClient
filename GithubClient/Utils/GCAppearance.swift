//
//  GCAppearance.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/19/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import UIKit

extension AppDelegate {
    func applyAppAppearance()  {
            UINavigationBar.appearance().barTintColor = UIColor.black
            UINavigationBar.appearance().tintColor = UIColor.white
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18)]
            UINavigationBar.appearance().isTranslucent = false
            UIApplication.shared.statusBarStyle = .lightContent
    }
}



