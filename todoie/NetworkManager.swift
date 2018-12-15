//
//  NetworkManager.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/12/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import Foundation

/**
 Network Manager is a class that will be holding all the calls and returning NetworkOperations
 */
class NetworkManager {
    
    // The base URL require for the NetworkManager to work
    private let baseURL: URL
    
    /**
     Takes the base url of the application so we can fetch data according to it
     - Parameters:
        - url: the Base url of the application
     */
    init(url: URL) {
        baseURL = url
    }
    
    /**
     Fetch the status okay from the server from the backend
     - returns: Network Operation that should be added to the operations queue
     */
    func fetchStatusOkay() -> NetworkOperation {
        return NetworkOperation(url: baseURL.appendingPathComponent("api"))
    }
}
