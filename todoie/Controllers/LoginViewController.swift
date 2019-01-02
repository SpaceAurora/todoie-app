//
//  ViewController.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/11/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import JGProgressHUD

class LoginViewController: UIViewController {
    
    private let loginViewModel = LoginViewModel()
    
    private let progressHud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .dark)
        return hud
    }()
    // UIComponents
    private let backgroundImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "background"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    // Sets up the Google sign up button
    private let customGoogleSignInButton: UIButtonTodoie = {
        let b = UIButtonTodoie(type: .system)
        b.setupButton(placeholder: "Google", color: .hotPink)
        b.addTarget(self, action: #selector(handleGoogleSignIn), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupGoogleSignIn()
        setupLoginViewModelObservers()
        setupView()
    }
    
}


//MARK:- Google Auth

extension LoginViewController: GIDSignInUIDelegate {
    
    fileprivate func setupGoogleSignIn() {
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    @objc fileprivate func handleGoogleSignIn() {
        loginViewModel.googleSignIn()
        setupHud(withText: "Sign up..")
    }
    
}

// MARK:- Hud Setup

extension LoginViewController {
    
    func setupHud(withText text: String) {
        progressHud.textLabel.text = text
        progressHud.show(in: view)
    }
}

//MARK:- Setup LoginViewModel

extension LoginViewController {
    
    func setupLoginViewModelObservers() {
        loginViewModel.isUserLoggedIn.bind { (isLoggedIn) in
            if isLoggedIn == true {
                self.progressHud.dismiss()
                self.dismiss(animated: true)
            }
        }
    }
}

extension LoginViewController {
    
    fileprivate func setupView() {
        view.addSubview(backgroundImage)
        view.addSubview(customGoogleSignInButton)
        NSLayoutConstraint.activate([
            
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            customGoogleSignInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            customGoogleSignInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            customGoogleSignInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            ])
    }
}
