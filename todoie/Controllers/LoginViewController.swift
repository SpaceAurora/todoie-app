//
//  ViewController.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/11/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import UIKit
import Firebase
import FacebookLogin
import GoogleSignIn
import JGProgressHUD

class LoginViewController: UIViewController {
    
    // constants
    private let loginViewModel = LoginViewModel()
    
    // UIComponents
    private let progressHud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .dark)
        return hud
    }()
    
    private let backgroundImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "background"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    private let logoImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Logo"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    private let continueLable: UILabelTodoieLogin = {
        let lb = UILabelTodoieLogin(frame: .zero)
        lb.text = "Continue With"
        return lb
    }()
            
    private let customGoogleSignInButton: UIButtonTodoie = {
        let b = UIButtonTodoie(type: .system)
        b.setupButton(placeholder: "Google", color: .opacityBackground, textColor: .hotPink)
        b.addTarget(self, action: #selector(handleGoogleSignIn), for: .touchUpInside)
        return b
    }()
    
    private let customFacebookSignInButton: UIButtonTodoie = {
        let b = UIButtonTodoie(type: .system)
        b.setupButton(placeholder: "Facebook", color: .opacityBackground, textColor: .facebookBlue)
        b.addTarget(self, action: #selector(handleFacebookSignIn), for: .touchUpInside)
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
    
    // Sets up the ui delegate
    fileprivate func setupGoogleSignIn() {
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    // Calls the ViewModel googleSignIn function
    @objc fileprivate func handleGoogleSignIn() {
        loginViewModel.googleSignIn()
        setupHud(withText: "Sign up..")
    }
    
}

//MARK:- Facebook Auth

extension LoginViewController {
    
    @objc func handleFacebookSignIn() {
        loginViewModel.facebookSignIn(viewController: self)
        setupHud(withText: "Sign up..")
    }
}

// MARK:- Hud Setup

extension LoginViewController {
    
    func showErrorHud(err: Error) {
        progressHud.dismiss()
        let errorHud = JGProgressHUD(style: .dark)
        errorHud.textLabel.text = "Failed Registration"
        errorHud.detailTextLabel.text =  err.localizedDescription
        errorHud.show(in: view)
        errorHud.dismiss(afterDelay: 2, animated: true)
    }
    
    func setupHud(withText text: String) {
        progressHud.textLabel.text = text
        progressHud.show(in: view)
    }
}

//MARK:- Setup LoginViewModel

extension LoginViewController {
    
    func setupLoginViewModelObservers() {
        
        // Binds the clousre with the object isUserLoggedIn
        loginViewModel.isUserLoggedIn.bind { [unowned self] (args) in
            guard let (isLoggedIn, error) = args else { return }
            
            // checkes for errors and pressents a hub with a error in it.
            if let err = error {
                self.showErrorHud(err: err)
                return
            }
            // dismisses and then if logged in shows the main view
            self.progressHud.dismiss()
            if isLoggedIn {
                self.dismiss(animated: true)
            }
        }
    }
}

//MARK:- UI Setup

extension LoginViewController {
    
    //Setup the View
    fileprivate func setupView() {
        view.addSubview(backgroundImage)
        view.addSubview(logoImage)
        let stackView = UIStackView(arrangedSubviews: [continueLable, customGoogleSignInButton, LoginSeparatorUIView(), customFacebookSignInButton])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            logoImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            logoImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            ])
    }
    
}
