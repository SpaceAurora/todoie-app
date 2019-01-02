//
//  NetworkManager.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/12/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import Foundation
import GoogleSignIn
import Firebase

/**
 Network Manager is a class that will be holding all the calls and returning NetworkOperations
 */
class NetworkManager {
    
    static let shared = NetworkManager()
    
    // Should
    func generateGoogleUserCredentials(user: GIDGoogleUser, completion: @escaping (Error?) -> ()) {
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        signInRetrieveData(credential: credential, completion: completion)
    }
    
    fileprivate func signInRetrieveData(credential: AuthCredential, completion: @escaping (Error?) -> ()) {
        Auth.auth().signInAndRetrieveData(with: credential) { (auth, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            self.saveUserToFireStore(authResult: auth, completion: completion)
        }
    }
    
    fileprivate func saveUserToFireStore(authResult: AuthDataResult?, completion: @escaping (Error?) -> ()){
        guard let uid = authResult?.user.uid else { return }
        let db = Firestore.firestore()
        
        let document = [
            "uid": uid,
            "timestamp": Int(Date().timeIntervalSince1970)
            ] as [String: Any]
        
        db.collection("Users").document(uid).setData(document) { (err) in
            completion(err)
        }
    }
    
}
