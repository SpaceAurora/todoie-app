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

class LoginViewModel: NSObject {
    
    var isUserLoggedIn = Bindable<Bool>()
    
    override init() {
        super.init()
        isUserLoggedIn.value = false
        setupGoogleLogin()
    }
}

//MARK:- Googles Sign up/Log In Implementation

extension LoginViewModel: GIDSignInDelegate {
    
    // Sets up the Google login required protocols and delegates to the ViewModel
    func setupGoogleLogin() {
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    // When the Google Login Button Is pressed this function is invoked
    func googleSignIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    // Google's magic Happens behind the scences and then this function recives all the magic
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            // TODO:- handle errors
            return
        }
        
        // Network manager should generate the google user Credentials and saves them
        NetworkManager.shared.generateGoogleUserCredentials(user: user) { (error) in
            if let err = error {
                print(err.localizedDescription)
                self.isUserLoggedIn.value = false
                return
            }
            // sets the isUserLoggedIn to true to notify the VC that this is done
            self.isUserLoggedIn.value = true
        }
    }
    
}

