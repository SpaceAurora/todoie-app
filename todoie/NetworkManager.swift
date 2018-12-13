//
//  NetworkManager.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/12/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private let baseURL: URL
    
    init(url: URL) {
        baseURL = url
    }
    
    // Fetch the status okay from the server from the backend
    func fetchStatusOkay() -> NetworkOperation {
        return NetworkOperation(url: baseURL.appendingPathComponent("api"))
    }
}
