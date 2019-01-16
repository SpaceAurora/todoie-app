//
//  FetchUserFacebookDataOperation.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/17/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FacebookCore

/**
 FetchUserFacebookDataOperation is a operation that fetches the required data from facebook
 and then returns them with a clousre
 */
class FetchUserFacebookDataOperation: Procedure {
    
    private let param = ["fields" : "email, first_name, last_name"]
    
    var didFinishFetch: ((TodoieUser?, Error?) -> Void)?
    
    override init() {
        super.init()
    }
    
    override func start() {
        // Cancels the operation and sends an notification that this operation is done
        if isCancelled {
            finishOperation()
            return
        }
        // fetching user data from facebook
        FBSDKGraphRequest.init(graphPath: "me", parameters:  param)?.start(completionHandler: { (sdkConnection, result, error) in
            if let err = error {
                self.fetching(user: nil, err: err)
                return
            }
            guard let user = result as? [String: Any] else { return }
            self.fetching(user: TodoieUser(facebookUser: user), err: nil)
        })
    }
    
    // Should always be called to notify other operations about the status of this one
    fileprivate func fetching(user: TodoieUser?, err: Error?) {
        finishOperation()
        didFinishFetch?(user, nil)
    }
}
