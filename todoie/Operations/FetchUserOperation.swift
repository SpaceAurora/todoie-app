//
//  FetchOperation.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/17/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation
import Firebase

/**
 FetchUserOperation is a operation that fetches the required data from Firestore
 and then returns them with a clousre
 */
class FetchUserOperation: Procedure {
    
    private let path: String
    
    var didFinishFetch: ((TodoieUser?, Error?)->Void)?
    
    init(path: String) {
        self.path = path
        super.init()
    }
    
    override func start() {
        // Cancels the operation and sends an notification that this operation is done
        if isCancelled {
            fetching(document: nil, err: OperationErrors.OperationCancelled("Cancelled Operation"))
            return
        }
        executing(true)
        // Retriving the uid of the user from firebase
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // getting the refrence of the document in firestore
        let database = Firestore.firestore().collection(path).document(uid)
        
        database.getDocument { (document, error) in
            if let err = error {
                self.fetching(document: nil, err: err)
                return
            }
            guard let doc = document?.data() else { return }

            // returning the document
            self.fetching(document: doc, err: nil)
        }
    }
    
    // Should always be called to notify other operations about the status of this one
    fileprivate func fetching(document: [String: Any]?, err: Error?) {
        finishOperation()
        guard let user = document else { return }
        didFinishFetch?(TodoieUser(firestore: user), nil)
    }
}
