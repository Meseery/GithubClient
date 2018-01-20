//
//  GCUserViewController.swift
//  GithubClient
//
//  Created by Mohamed EL Meseery on 1/19/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import UIKit

class GCUserViewController: UIViewController {
    
    @IBOutlet weak var _usernameTextField: UITextField! {
        didSet{
            _usernameTextField.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func didTapGetRepos(_ sender: UIButton) {
        fetchRepos(ofUser: _usernameTextField.text)
    }
    
    func fetchRepos(ofUser username:String?)  {
        guard username != nil else {
            AlertView.showAlert(WithMessage: "Please enter valid Github username")
            return
        }
        let repoListScene = StoryboardScene.Main.gcReposViewController.instantiate()
        repoListScene.userName = username
        self.navigationController?.pushViewController(repoListScene, animated: true)
    }
    
}

extension GCUserViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        fetchRepos(ofUser: textField.text)
        return true
    }
}
