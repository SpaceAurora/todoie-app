//
//  SaveOperation.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/19/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation
import Firebase

/**
 SaveOperation is an operation that runs on firebase and saves the task data to firestore.
 */
class SaveOperation<T: SaveOperationProtocol>: Procedure {
    
    // DataWrapper
    private let urlWrapper: DataWrapper<String>?
    
    // data the confirms to the SaveOperationProtocol
    private var data: T
    // refrence the the collection
    private let ref: CollectionReference
    
    // Should be called after finishing the save
    var didSave: ((Bool, Error?) -> Void)?
    
    init(data: T, databaseRef: CollectionReference, urlWrapper: DataWrapper<String>?) {
        self.data = data
        self.ref = databaseRef
        self.urlWrapper = urlWrapper
        super.init()
    }
    
    override func start() {
        // Cancels the operation and sends an notification that this operation is done
        if isCancelled {
            didFinishWithNoErrors(false, err: OperationErrors.OperationCancelled("Operation is Cancelled"))
            return
        }
        // gets the uploaded data
        let uploadData = getUploadData()
        
        // double checks if we have a uid
        guard let uid = data.uid else {
            didFinishWithNoErrors(false, err: OperationErrors.OperationCancelled("No uid found"))
            return
            
        }
        // normal save to the server
        ref.document(uid).setData(uploadData) { (error) in
            if let err = error {
                print(err.localizedDescription)
                self.didFinishWithNoErrors(false, err: err)
                return
            }
            self.didFinishWithNoErrors(true, err: nil)
        }
    }
    
    // Should always be called to notify other operations about the status of this one
    fileprivate func didFinishWithNoErrors(_ finish: Bool, err: Error?) {
        finishOperation()
        didSave?(finish, err)
    }
    
    // returns the document we will be saving to firestore
    fileprivate func getUploadData() -> [String: Any] {
        
        // checks if we have a uid already, and if we are uploading an image "task with an image"
        if let uid = data.uid, let wrapper = urlWrapper {
            return data.getDocument(withUID:uid, withUrl: wrapper.data)
        }
        
        // gets the uid of the current user and sends it to the model "will only be invoked if it's the log or signup time
        if let uid = Auth.auth().currentUser?.uid, let wrapper = urlWrapper {
            return data.getDocument(withUID: uid, withUrl: wrapper.data)
        }
       
        // returns the document if we have a uid but no wrapper "task"
        return data.getDocument()
    }
}
