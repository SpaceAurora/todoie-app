//
//  Bindable.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/2/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation

class Bindable<T>{
    
    // oberver is the function that will be called when the value changes with the value
    fileprivate var observer: ((T?)->())?
    
    // value is the new value inputed to the bindable object
    var value: T? {
        didSet {
            observer?(value)
        }
    }

    /**
    binds the code from the ViewController to the ViewModel
     - Parameters:
        - observer: clousre the will be called when the value is changed
     */
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
