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
    
    // Should generate the google credentials that came back from the google one click button
    func generateGoogleUserCredentials(user: GIDGoogleUser, completion: @escaping (Error?) -> ()) {
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        signInRetrieveData(credential: credential, completion: completion)
    }
    
    // Takes in the credentials and then adds it to the Auth Database
    fileprivate func signInRetrieveData(credential: AuthCredential, completion: @escaping (Error?) -> ()) {
        Auth.auth().signInAndRetrieveData(with: credential) { (auth, error) in
            if let err = error {
                print(err.localizedDescription)
                completion(err)
                return
            }
            self.saveUserToFireStore(authResult: auth, completion: completion)
        }
    }
    
    // Saves the user by his UID in firestore
    fileprivate func saveUserToFireStore(authResult: AuthDataResult?, completion: @escaping (Error?) -> ()){
        guard let uid = authResult?.user.uid else { return }
        let db = Firestore.firestore()
        
        let document = [
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
    
}
