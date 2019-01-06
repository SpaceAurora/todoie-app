//
//  NetworkManager.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/12/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import Foundation
import GoogleSignIn
import FBSDKCoreKit
import FacebookCore
import Firebase

/**
 Network Manager is a class that will be holding all the calls and returning NetworkOperations
 */
class NetworkManager {
    
    static let shared = NetworkManager()
    
}

//MARK:- Requests that create users belong here

extension NetworkManager {
    
    // Should generate the google credentials that came back from the google one click button
    func generateGoogleUserCredentials(user: GIDGoogleUser, completion: @escaping (Error?) -> ()) {
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        signInRetrieveData(user: TodoieUser(googleUser: user), credential: credential, completion: completion)
    }
    
    func generateFacebookUserCredentials(accessToken: AccessToken, completion: @escaping (Error?) -> ()) {
        
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
        getFacebookUserInformation { (user, error) in
            if let err = error {
                print(err.localizedDescription)
                completion(err)
                return
            }
            guard let user = user else { return }
            self.signInRetrieveData(user: user, credential: credential, completion: completion)
        }
    }
    
    // Takes in the credentials and then adds it to the Auth Database
    fileprivate func signInRetrieveData(user: TodoieUser, credential: AuthCredential, completion: @escaping (Error?) -> ()) {
        Auth.auth().signInAndRetrieveData(with: credential) { (auth, error) in
            if let err = error {
                print(err.localizedDescription)
                completion(err)
                return
            }
            self.saveUserToFireStore(user: user, authResult: auth, completion: completion)
        }
    }
    
    // Saves the user by his UID in firestore
    fileprivate func saveUserToFireStore(user: TodoieUser, authResult: AuthDataResult?, completion: @escaping (Error?) -> ()){
        guard let uid = authResult?.user.uid else { return }
        let db = Firestore.firestore()
        
        let document = [
            "firstName": user.firstName,
            "lastName": user.lastName,
            "email": user.email,
            "uid": uid,
            "timestamp": Int(Date().timeIntervalSince1970)
            ] as [String: Any]
        
        db.collection("Users").document(uid).setData(document) { (error) in
            if let err = error {
                print(err.localizedDescription)
                completion(err)
                return
            }
            completion(nil)
        }
    }
    
    fileprivate func getFacebookUserInformation(completion: @escaping (TodoieUser?, Error?) -> ()) {
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields" : "email, first_name, last_name"])?.start(completionHandler: { (sdkConnection, result, error) in
            if let err = error {
                print(err.localizedDescription)
                completion(nil, err)
                return
            }
            guard let user = result as? [String: Any] else { return }
            
            completion(TodoieUser(facebookUser: user), nil)
        })
    }
    
}
