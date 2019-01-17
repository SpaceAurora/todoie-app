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
import FacebookLogin
import FacebookCore

class LoginViewModel: NSObject {
    
    var isUserLoggedIn = Bindable<(Bool,Error?)>()
    
    override init() {
        super.init()
        isUserLoggedIn.value = (false, nil)
        setupGoogleLogin()
    }
}

//MARK:- Googles Sign up/Log In Implementation

extension LoginViewModel: GIDSignInDelegate {
    
    // Sets up the Google login required protocols and delegates to the ViewModel
    fileprivate func setupGoogleLogin() {
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    // When the Google Login Button Is pressed this function is invoked
    func googleSignIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    // Google's magic Happens behind the scences and then this function recives all the magic
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let err = error {
            self.isUserLoggedIn.value = (false, err)
            return
        }
        
        // Network manager should generate the google user Credentials and saves them
        NetworkManager.shared.generateGoogleUserCredentials(user: user) { (signup, error) in
            DispatchQueue.main.async {
                if let err = error {
                    self.isUserLoggedIn.value = (signup, err)
                    return
                }
                // sets the isUserLoggedIn to true to notify the VC that this is done
                self.isUserLoggedIn.value = (signup, nil)
            }
        }
    }
    
}

//MARK:- Facebook Sign Up/log in implementation

extension LoginViewModel {
    
    /**
     facebook signin implementes the code needed to sign up and log in with facebook
     - Parameters:
        - viewController: Takes in the viewController the facebook button is in so it pushes the sign up page on it.
     */
    func facebookSignIn(viewController: UIViewController) {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: viewController) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                self.isUserLoggedIn.value = (false, error)
            case .cancelled:
                self.isUserLoggedIn.value = (false, nil)
            case .success(_, _, let accessToken):
                self.handleCreatingFirebaseUser(accessToken: accessToken)
            }
        }
    }
    
    // Removed code from the facebookSignIn to ease reading
    fileprivate func handleCreatingFirebaseUser(accessToken: AccessToken) {
        NetworkManager.shared.generateFacebookUserCredentials(accessToken:  accessToken, completion: { (signup, error) in
            DispatchQueue.main.async {
                if let err = error {
                    self.isUserLoggedIn.value = (signup, err)
                    return
                }
                self.isUserLoggedIn.value = (signup, nil)
            }
        })
    }
}
