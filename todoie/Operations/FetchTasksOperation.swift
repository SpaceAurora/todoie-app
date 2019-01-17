//
//  FetchTasksOperation.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/17/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation
import Firebase

/**
 FetchTaskOperation is a operation that fetches the required data from Firestore
 and then returns them with a clousre
 */
class FetchTaskOperation: Procedure {
    
    private let path: String
    private let userTasks = FirebaseCalls.UserTasks.rawValue
    
    var didFinishFetch: (([Todo], Error?)->Void)?
    
    init(path: String) {
        self.path = path
        super.init()
    }
    
    override func start() {
        // Cancels the operation and sends an notification that this operation is done
        if isCancelled {
            fetching(todos: nil, err: OperationErrors.OperationCancelled("Cancelled Operation"))
            return
        }
        
        executing(true)
        // retriving the uid of the user from firebase
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // getting the refrence of the document in firestore
        let database = Firestore.firestore().collection(path).document(uid).collection(userTasks)
        
        // should add pagenation
        
        database.getDocuments { (snapshot, error) in
            if let err = error {
                self.fetching(todos: nil, err: err)
                return
            }
            let todos = snapshot?.documents.map({ (snap) -> Todo in
                return Todo(document: snap.data())
            })
            // Returning the todos
            self.fetching(todos: todos, err: nil)
        }
    }
    
    // Should always be called to notify other operations about the status of this one
    fileprivate func fetching(todos: [Todo]?, err: Error?) {
        finishOperation()
        didFinishFetch?(todos ?? [], err)
    }
}

