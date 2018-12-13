//
//  NetworkOperation.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/13/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import Foundation

class NetworkOperation: Procedure {
    
    // Gets the url that's supposed to fetch the data from
    private let _url: URL
    
    // The output is set as Data
    var output: Data?
    var error: Error?
    
    init(url: URL) {
        _url = url
        super.init()
    }
    
    override func start() {
        // Cancels the operation and sends an notification that this operation is done
        if isCancelled {
            finishOperation()
            return
        }
        
        // sets the operation to executing
        executing(true)
        
        // Fetch data from the internet
        URLSession.shared.dataTask(with: _url) { [weak self] (data, urlResponse, err) in
            // sets the data and allows the completion block to exec
            self?.output = data
            self?.error = err
            self?.finishOperation()
            }.resume()
    }
    
}
