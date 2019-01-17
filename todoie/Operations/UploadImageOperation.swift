//
//  UploadImageOperation.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/13/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import UIKit
import Firebase

/**
 UploadImageOperation is a class that will be handling all the Async requests for us using operations
 Instead of using GCD
 */
class UploadImageOperation: Procedure {
    
    // DataWrappers to transfer data within operations
    private let authWrapper: DataWrapper<Bool>
    private let imgDataWrapper: DataWrapper<UIImage>
    private let urlWrapper: DataWrapper<String>
    
    // filename and Storage refrence
    private let filename = UUID().uuidString
    private lazy var ref = Storage.storage().reference(withPath: "/\(FirebaseCalls.ProfileImages.rawValue)/\(filename)")
    
    var didUploadUserImage: ((String?, Error?)-> Void)?
    
    init(authWrapper auth: DataWrapper<Bool>, imageWrapper image: DataWrapper<UIImage>, urlWrapper url: DataWrapper<String>) {
        self.authWrapper = auth
        self.imgDataWrapper = image
        self.urlWrapper = url
        super.init()
    }
    
    override func start() {
        // Cancels the operation and sends an notification that this operation is done or if the user is not logged in
        if let err = authWrapper.error, isCancelled || authWrapper.data == false {
            isCancelled = true
            didEncouterError(err: err)
            return
        }
        // jumps over the upload code if there is nothing to upload
        if let err = imgDataWrapper.error, isCancelled {
            didEncouterError(err: err)
            return
        }
        // Handles encoding images to Data to be transfered
        guard let img = imgDataWrapper.data, let data = img.jpegData(compressionQuality: 0.7) else {
            didEncouterError(err: OperationErrors.ImageEncoding("Couldn't encode image"))
            return
        }
        
        executing(true)
        
        // Pushes the image to the server
        ref.putData(data, metadata: nil) { (store, error) in
            if let err = error {
                self.didEncouterError(err: err)
                return
            }
            self.getDownloadUrl()
        }
    }
    
    // Gets the download string from the server
    fileprivate func getDownloadUrl() {
        ref.downloadURL(completion: { (url, error) in
            if let err = error {
                self.didEncouterError(err: err)
                return
            }
            guard let url = url?.absoluteString else { return }
            
            // Transforms the url to a string and returns it
            self.didFinishUploading(url: url)
        })
    }
    
    // Function that handles errors
    fileprivate func didEncouterError(err: Error) {
        finishOperation()
        didUploadUserImage?(nil, err)
    }
    
    // sets the urlWrapper data to the url.absoluteString in case the upload is successful
    fileprivate func didFinishUploading(url: String?) {
        finishOperation()
        urlWrapper.data = url
        didUploadUserImage?(nil, nil)
    }
    
}
