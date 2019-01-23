//
//  OperationManager.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/18/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class OperationManager {
    
    static let shared = OperationManager()
    /**
     Prepares the Fetching operation
     - Parameters:
         - credential: Firebase generated credentials
         - authWrapper: DataWrapper object that links Auth operation with any following operation
         - completion: The completion clousre that should be invoked at the end of the call
     - returns: AuthOperation
     */
    func authOperation(credential: AuthCredential, authWrapper: DataWrapper<Bool>, completion: @escaping (Bool, Error?) -> ()) -> AuthOperation {
        let authOperation = AuthOperation(credential: credential, authWrapper: authWrapper)
        authOperation.didAuthenticateUser = { [unowned self] (_, error) in
            if let err = error {
                completion(false, err)
                return
            }
        }
        return authOperation
    }
    
    /**
     Prepares the Fetching operation
     - Parameters:
         - user: TodoieUser
         - urlWrapper: DataWrapper object that links saving user with the upload operation
         - completion: The completion clousre that should be invoked at the end of the call
     - returns: SaveUserOperation
     */
    func saveUserOperation(user: TodoieUser, urlWrapper: DataWrapper<String>, completion: @escaping (Bool, Error?) -> ()) -> SaveOperation<TodoieUser> {
        let saveOperation = SaveOperation<TodoieUser>(data: user, databaseRef: CollectionReference.saveUser(), urlWrapper: urlWrapper)
        saveOperation.didSave = { [unowned self] (loggedIn, error) in
            if let err = error {
                completion(loggedIn, err)
                return
            }
            completion(loggedIn, nil)
        }
        return saveOperation
    }
    
    /**
     Prepares the Fetching operation
     - Parameters:
         - path: The path of the users in firestore
         - completion: The completion clousre that should be invoked at the end of the call
     - returns: FetchOperation
     */
    func fetchUserOperation(path: String, completion: @escaping (TodoieUser?, Error?) -> ()) -> FetchUserOperation {
        let fetchOperation = FetchUserOperation(path: path)
        fetchOperation.didFinishFetch = { (user, error) in
            completion(user, error)
        }
        return fetchOperation
    }
    
    /**
     Prepares the Fetching operation
     - Parameters:
         - url: Url of the image to be fetched
         - urlWrapper: DataWrapper object that links saving user with the upload operation
         - completion: The completion clousre that should be invoked at the end of the call
     */
    func downloadImageOperation(url: URL, imageWrapper: DataWrapper<UIImage>, completion: ((UIImage?, Error?) -> ())?) -> DownloadImagesOperation {
        let downloadOperation = DownloadImagesOperation(url: url, data: imageWrapper)
        downloadOperation.didDownloadUserImage = { (image, error) in
            
            // if completion is nil ignore
            completion?(image, error)
        }
        return downloadOperation
    }
    
    func fetchUserTasksOperation(query: Query, completion: @escaping ([Task], Error?) -> ()) -> FetchTaskOperation {
        let fetchOperation = FetchTaskOperation(query: query)
        fetchOperation.didFinishFetch = { (tasks, error) in
            completion(tasks, error)
        }
        return fetchOperation
    }
    
    func saveUserTaskOperation(userId: String, data: Task, completion: @escaping (Bool, Error?) -> Void) -> SaveOperation<Task> {
        
        let saveOperation = SaveOperation<Task>(data: data, databaseRef: CollectionReference.saveTask(userUID: userId), urlWrapper: nil)
        saveOperation.didSave = { (isUploaded, error) in
            if let err = error {
                completion(isUploaded, err)
                return
            }
            completion(isUploaded, nil)
        }
        return saveOperation
    }
}
