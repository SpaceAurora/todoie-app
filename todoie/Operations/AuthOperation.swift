//
//  AuthOperation.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/17/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation
import Firebase

class AuthOperation: Procedure {
    
    private let credential: AuthCredential
    private let authWrapper: DataWrapper<Bool>
    
    var didAuthenticateUser: ((Bool?, Error?) -> Void)?
    
    init(credential: AuthCredential, authWrapper: DataWrapper<Bool>) {
        self.credential = credential
        self.authWrapper = authWrapper
        super.init()
    }
    
    override func start() {
        // Cancels the operation and sends an notification that this operation is done
        if isCancelled {
            didEncounterError(err: OperationErrors.OperationCancelled("Operation is cancelled"))
            return
        }

        Auth.auth().signInAndRetrieveData(with: credential) { (auth, error) in
            if let err = error {
                self.didEncounterError(err: err)
                return
            }
            self.didFinishedAuthenticating(true, err: nil)
        }
    }
    
    // Handles errors in case the operation fails
    fileprivate func didEncounterError(err: Error?) {
        finishOperation()
        isCancelled = true
        authWrapper.data = false
        authWrapper.error = err
        didAuthenticateUser?(nil, err)
    }
    
    // Sets the wrappers to the values we just got
    fileprivate func didFinishedAuthenticating(_ done: Bool, err: Error?) {
        finishOperation()
        authWrapper.data = done
        authWrapper.error = err
    }
}
