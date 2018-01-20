//
//  Resignable.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/19/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import UIKit

protocol Resginable {
    func resignOnTap(viewController: UIViewController)
}

extension Resginable{
    func resignOnTap(viewController: UIViewController){
        let tapSelector = #selector(viewController.resignFirstResponder)
        let tapGesture = UITapGestureRecognizer(target: viewController, action:tapSelector)
        viewController.view.addGestureRecognizer(tapGesture)
    }
}
