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
import SDWebImage

// Enum to save all the collections names
enum FirebaseCalls: String {
    case Users, ProfileImages, Tasks, UserTasks
}

/**
 Network Manager is a class that will be holding all the calls and returning NetworkOperations
 */
class NetworkManager {
    
    // Operations queue with 5 max concurrent operations
    private let operationQueue: OperationQueue = {
        let q = OperationQueue()
        q.maxConcurrentOperationCount = 5
        return q
    }()
    
    static let shared = NetworkManager()
}

//MARK:- Requests that create users belong here

extension NetworkManager {
    
    // Should generate the google credentials that came back from the google one click button
    func generateGoogleUserCredentials(user: GIDGoogleUser, completion: @escaping (Bool, Error?) -> ()) {
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // starts the login operations process
        signInRetrieveData(user: TodoieUser(googleUser: user), credential: credential, completion: completion)
    }
    
    func generateFacebookUserCredentials(accessToken: AccessToken, completion: @escaping (Bool, Error?) -> ()) {
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
        let facebookOperation = FetchUserFacebookDataOperation()
        
        // Facebook fetch operation
        facebookOperation.didFinishFetch = { [unowned self] (user, error) in
            if let err = error {
                completion(false, err)
                return
            }
            guard let user = user else { return }
            // starts the login operations process
            self.signInRetrieveData(user: user, credential: credential, completion: completion)
        }
        
        operationQueue.addOperation(facebookOperation)
    }
    
    // Takes in the credentials and sets up the operations required to fire the Auth process
    fileprivate func signInRetrieveData(user: TodoieUser, credential: AuthCredential, completion: @escaping (Bool, Error?) -> ()) {
        
        guard let url = URL(string: user.imageURL) else {
            completion(false, nil)
            return
        }
        
        // DataWrappers
        let authWrapper = DataWrapper<Bool>()
        let imgWrapper = DataWrapper<UIImage>()
        let urlWrapper = DataWrapper<String>()
        
        // init all the operations needed
        let authOperation = networkAuthOperation(credential: credential, authWrapper: authWrapper, completion: completion)
        let downloadOperation =  networkDownloadImageOperation(url: url, imageWrapper: imgWrapper, completion: nil)
        let uploadOperation = UploadImageOperation(authWrapper: authWrapper, imageWrapper: imgWrapper, urlWrapper: urlWrapper)
        let saveOperation = networkSaveUserOperation(user: user, urlWrapper: urlWrapper, completion: completion)
        
        // adding dependencies
        uploadOperation.addDependency(downloadOperation)
        uploadOperation.addDependency(authOperation)
        saveOperation.addDependency(uploadOperation)
        
        // queueing up the operations
        operationQueue.addOperations([authOperation, downloadOperation, uploadOperation, saveOperation], waitUntilFinished: false)
    }
    
}

//MARK:- User Networking calls

extension NetworkManager {
    
    func fetchHomeViewData(userCompletion: @escaping (TodoieUser?, Error?) -> (), taskCompletion: @escaping ([Todo], Error?) -> ()) {
        let fetchUser = networkFetchUserOperation(path: FirebaseCalls.Users.rawValue, completion: userCompletion)
        let fetchTasks = networkFetchUserTasksOperation(path: FirebaseCalls.Tasks.rawValue, completion: taskCompletion)
        fetchTasks.addDependency(fetchUser)
        operationQueue.addOperations([fetchUser, fetchTasks], waitUntilFinished: false)
    }
    
    // fetches the current user from firestore
    func fetchUser(completion: @escaping (TodoieUser?, Error?) -> ()) {
        let fetchOperation = networkFetchUserOperation(path: FirebaseCalls.Users.rawValue, completion: completion)
        operationQueue.addOperation(fetchOperation)
    }
    
    /**
     Prepares the Fetching operation
     - Parameters:
         - url: Url of the image to be fetched
         - completion: The completion clousre that should be invoked at the end of the call
     */
    func fetchProfileImage(url: URL, completion: @escaping (UIImage?, Error?) -> ()) {
        let imageWrapper = DataWrapper<UIImage>()
        let downloadOperation = networkDownloadImageOperation(url: url, imageWrapper: imageWrapper, completion: completion)
        operationQueue.addOperation(downloadOperation)
    }
    
    func fetchTasks(completion: @escaping ([Todo], Error?) -> Void) {
        let operation = networkFetchUserTasksOperation(path: FirebaseCalls.Tasks.rawValue, completion: completion)
        operationQueue.addOperation(operation)
    }
}

//MARK:- operations

extension NetworkManager {
    
    /**
     Prepares the Fetching operation
     - Parameters:
         - credential: Firebase generated credentials
         - authWrapper: DataWrapper object that links Auth operation with any following operation
         - completion: The completion clousre that should be invoked at the end of the call
     - returns: AuthOperation
     */
    fileprivate func networkAuthOperation(credential: AuthCredential, authWrapper: DataWrapper<Bool>, completion: @escaping (Bool, Error?) -> ()) -> AuthOperation {
        let authOperation = AuthOperation(credential: credential, authWrapper: authWrapper)
        authOperation.didAuthenticateUser = { [unowned self] (_, error) in
            if let err = error {
                completion(false, err)
                self.operationQueue.cancelAllOperations()
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
    fileprivate func networkSaveUserOperation(user: TodoieUser, urlWrapper: DataWrapper<String>, completion: @escaping (Bool, Error?) -> ()) -> SaveUserOperation {
        let saveOperation = SaveUserOperation(user: user, urlWrapper: urlWrapper)
        saveOperation.didSaveUserInformation = { [unowned self] (loggedIn, error) in
            if let err = error {
                completion(loggedIn, err)
                self.operationQueue.cancelAllOperations()
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
    fileprivate func networkFetchUserOperation(path: String, completion: @escaping (TodoieUser?, Error?) -> ()) -> FetchUserOperation {
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
    fileprivate func networkDownloadImageOperation(url: URL, imageWrapper: DataWrapper<UIImage>, completion: ((UIImage?, Error?) -> ())?) -> DownloadImagesOperation {
        let downloadOperation = DownloadImagesOperation(url: url, data: imageWrapper)
        downloadOperation.didDownloadUserImage = { (image, error) in
            
            // if completion is nil ignore
            completion?(image, error)
        }
        return downloadOperation
    }
    
    fileprivate func networkFetchUserTasksOperation(path: String, completion: @escaping ([Todo], Error?) -> ()) -> FetchTaskOperation {
        let fetchOperation = FetchTaskOperation(path: path)
        fetchOperation.didFinishFetch = { (todos, error) in
            completion(todos, error)
        }
        return fetchOperation
    }
    
}
