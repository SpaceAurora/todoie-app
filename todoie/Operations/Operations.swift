//
//  Operations.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/13/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import Foundation

class Procedure: Operation {
    
    private var _isExecuting = false
    private var _isAsync = false
    private var _isFinished = false
    private var _isCancelled = false
    
    override var isAsynchronous: Bool {
        get {
            return _isAsync
        }
        set {
            willChangeValue(forKey: "isAsynchronous")
            _isAsync = newValue
            didChangeValue(forKey: "isAsynchronous")
        }
    }
    
    override var isExecuting: Bool {
        get {
            return _isExecuting
        }
        set {
            willChangeValue(forKey: "isExecuting")
            _isExecuting = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    override var isFinished: Bool {
        get {
            return _isFinished
        }
        set {
            willChangeValue(forKey: "isFinished")
            _isFinished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isCancelled: Bool {
        get {
            return _isCancelled
        }
        set {
            willChangeValue(forKey: "isCancelled")
            _isCancelled = newValue
            didChangeValue(forKey: "isCancelled")
        }
    }
    
    func finishOperation() {
        isExecuting = false
        isFinished = true
    }
    
    func executing(_ executing: Bool) {
        isExecuting = executing
    }
    
}

