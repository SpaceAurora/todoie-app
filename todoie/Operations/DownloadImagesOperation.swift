//
//  DownloadImagesOperation.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/17/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation
import SDWebImage

/**
 DownloadingImagesOperation is an operation that runs with sdwebimage framework.
 It runs the code to retrive the image from a source aysnc and then returns the with didDownloadUserImage clousre
 */
class DownloadImagesOperation: Procedure {

    // Required Url to Downloed the image
    private let url: URL
    // Data wrapper to transfer data within Operations
    private let dataWrapper: DataWrapper<UIImage>
    
    // A function to return the needed image or error when needed
    var didDownloadUserImage: ((UIImage?, Error?) -> Void)?
    
    init(url: URL, data: DataWrapper<UIImage>) {
        self.dataWrapper = data
        self.url = url
        super.init()
    }
    
    override func main() {
        // Cancels the operation and sends an notification that this operation is done
        if isCancelled {
            // if all operations are cancelled, we return an error
            didDownloadUserImage?(nil, OperationErrors.ErrorDownloadingImage("Error downloading Image"))
            finishOperation()
            return
        }
        // sets the operation to executing
        executing(true)
        
        // Checks if the image is in our cache, if not it downloads it
        SDWebImageManager.shared().loadImage(with: url, options: .continueInBackground, progress: nil) { (img, _, err, _, _, _) in
            self.finishOperation()
            self.didDownloadUserImage?(img, err)
            self.dataWrapper.data = img
            self.dataWrapper.error = err
        }
    }
    
}
