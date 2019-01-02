//
//  LoginViewModel.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/2/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

class LoginViewModel: NSObject, GIDSignInDelegate {
    
    var isUserLoggedIn = Bindable<Bool>()
    
    override init() {
        super.init()
        isUserLoggedIn.value = false
        setupGoogleLogin()
    }
    
    func setupGoogleLogin() {
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func googleSignIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            // TODO:- handle errors
            return
        }
        
        NetworkManager.shared.generateGoogleUserCredentials(user: user) { (error) in
            if let err = error {
                print(err.localizedDescription)
            }
            self.isUserLoggedIn.value = true
        }
    }
    
}

