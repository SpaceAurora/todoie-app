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
    
    // getting the refrence of the document in firestore
    private let database: Query

    var didFinishFetch: (([Task], Error?)->Void)?
    
    init(query: Query) {
        self.database = query
        super.init()
    }
    
    override func start() {
        // Cancels the operation and sends an notification that this operation is done
        if isCancelled {
            fetching(tasks: nil, err: OperationErrors.OperationCancelled("Cancelled Operation"))
            return
        }
        
        executing(true)
        // should add pagenation
        
        database.getDocuments { (snapshot, error) in
            if let err = error {
                self.fetching(tasks: nil, err: err)
                return
            }
            let tasks = snapshot?.documents.map({ (snap) -> Task in
                return Task(document: snap.data())
            })
            // Returning the tasks
            self.fetching(tasks: tasks, err: nil)
        }
    }
    
    // Should always be called to notify other operations about the status of this one
    fileprivate func fetching(tasks: [Task]?, err: Error?) {
        finishOperation()
        didFinishFetch?(tasks ?? [], err)
    }
}

