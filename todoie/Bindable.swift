//
//  Bindable.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/2/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation

class Bindable<T>{
    
    fileprivate var observer: ((T?)->())?
    
    var value: T? {
        didSet {
            observer?(value)
        }
    }

    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
