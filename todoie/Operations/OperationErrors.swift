//
//  OperationErrors.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/17/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation

// OperationErrors is an enum that has all the operation errors.
enum OperationErrors: Error {
    case OperationCancelled(String),
        ErrorDownloadingImage(String),
        NoUserFound(String),
        ImageEncoding(String)
}
