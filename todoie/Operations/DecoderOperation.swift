//
//  DecoderOperation.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/13/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import Foundation

class DecoderOperation<T: Decodable>: Procedure {
    
    // Get's an input from Anyother Operation to decode
    var input: Data?
    var output: T?
    
    override init() {
        
        super.init()
    }
    
    override func start() {
        
        if isCancelled {
            finishOperation()
            return
        }
        executing(true)
        guard let data = input else {
            finishOperation()
            return
        }
        // decoding the data and setting it to the output to be released
        output = try? JSONDecoder().decode(T.self, from: data)
        finishOperation()
        
    }
}
