//
//  Todo.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/14/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation

struct Todo {
    //TODO: Implement the todo model
    let task: String
    
    init(document: [String: Any]) {
        task = document["task"] as? String ?? ""
    }
}
