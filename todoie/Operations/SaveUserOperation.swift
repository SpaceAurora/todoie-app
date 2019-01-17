//
//  SaveUserOperation.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/17/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation
import Firebase

/**
 SaveUserOperation is an operation that runs on firebase and saves the user data to firestore.
 */
class SaveUserOperation: Procedure {
    
    // DataWrapper
    private let urlWrapper: DataWrapper<String>
    // User to be uploaded
    private let user: TodoieUser
    
    var didSaveUserInformation: ((Bool, Error?) -> Void)?
    
    init(user: TodoieUser, urlWrapper: DataWrapper<String>) {
        self.urlWrapper = urlWrapper
        self.user = user
        super.init()
    }

    override func start() {
        // Cancels the operation and sends an notification that this operation is done
        if isCancelled {
            didFinishWithNoErrors(false, err: OperationErrors.OperationCancelled("Operation is Cancelled"))
            return
        }
        
        // gets the User uid, from firebase.
        guard let userUid = Auth.auth().currentUser?.uid else {
            // Panics in case of an error
            didFinishWithNoErrors(false, err: OperationErrors.NoUserFound("User isn't found"))
            return
        }
        
        let userData = getDocument(user: user, withUrl: urlWrapper.data)
        
        // uploads the new data for the current user to firebase
        Firestore.firestore().collection(FirebaseCalls.Users.rawValue).document(userUid).setData(userData) { (error) in
            if let err = error {
                self.didFinishWithNoErrors(false, err: err)
                return
            }
            self.didFinishWithNoErrors(true, err: nil)
        }
    }
    
    // Should always be called to notify other operations about the status of this one
    fileprivate func didFinishWithNoErrors(_ finish: Bool, err: Error?) {
        finishOperation()
        didSaveUserInformation?(finish, nil)
    }
    
    // sets the document we will upload
    fileprivate func getDocument(user: TodoieUser, withUrl url: String?) -> [String: Any] {
        guard let uid = Auth.auth().currentUser?.uid else { return ["":""]}
        return [
            "firstName": user.firstName,
            "lastName": user.lastName,
            "email": user.email,
            "uid": uid,
            "profileImageURL": url ?? "",
            "timestamp": Int(Date().timeIntervalSince1970)
        ]
    }
    
}
