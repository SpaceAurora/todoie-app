//
//  DataWrapper.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/17/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation

// DataWrapper is a class that incloses the data that will be transfered between
// operations. It's generic to fit all types
class DataWrapper<T> {
    var data: T?
    var error: Error?
}
