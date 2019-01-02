//
//  HomeViewController.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/2/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("user: ", Auth.auth().currentUser)
        if Auth.auth().currentUser == nil {
            let loginVC = UINavigationController(rootViewController: LoginViewController())
            present(loginVC, animated: true)
        }
    }
}
