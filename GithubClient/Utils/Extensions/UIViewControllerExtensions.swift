//
//  UIViewControllerExtensions.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/20/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import UIKit

extension UIViewController {
    func addBackButton(withImage image: UIImage){
        let button = UIButton(frame:CGRect(x:0, y:0, width:40, height:40))
        button.imageEdgeInsets = UIEdgeInsetsMake(0,-25,0,0)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func addRightNavigationButton(withImage image: UIImage? = nil,
                                  title:String,
                                  action:Selector){
        let button = UIButton(frame:CGRect(x:0, y:0, width:40, height:40))
        button.imageEdgeInsets = UIEdgeInsetsMake(0,-25,0,0)
        if image != nil {
            button.setImage(image, for: .normal)
        }
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func backTapped()  {
        self.navigationController?.popViewController(animated: true)
    }
}
