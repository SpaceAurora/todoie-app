//
//  SaveOperationProtocol.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/19/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation

protocol SaveOperationProtocol {
    
    var uid: String? {get set}
    func getDocument() -> [String: Any]
    func getDocument(withUID id: String, withUrl url: String?) -> [String: Any]
    
}
