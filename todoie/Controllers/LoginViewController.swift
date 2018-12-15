//
//  ViewController.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/11/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Consts
    
    // Vars
    
    // UIComponents
    private let backgroundImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "background"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    // with rendering mode will just render the original picture provided
    private let u = UITextFieldTodoie(withImage: #imageLiteral(resourceName: "user").withRenderingMode(.alwaysOriginal), placeholder: "Username")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImage)
        view.addSubview(u)
        NSLayoutConstraint.activate([
            
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            u.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            u.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            u.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            u.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

}
