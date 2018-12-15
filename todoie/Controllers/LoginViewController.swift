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
    private let signInButton: UIButtonTodoie = {
        let b = UIButtonTodoie(type: .system)
        b.setupButton(placeholder: "Sign In")
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImage)
        view.addSubview(u)
        view.addSubview(signInButton)
        NSLayoutConstraint.activate([
            
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            u.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            u.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            u.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            u.heightAnchor.constraint(equalToConstant: 40),
            
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signInButton.topAnchor.constraint(equalTo: u.bottomAnchor, constant: 20),
            signInButton.heightAnchor.constraint(equalToConstant: 40)
            ])
    }

}
