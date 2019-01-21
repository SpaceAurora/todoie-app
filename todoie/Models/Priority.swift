//
//  Priority.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/19/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

enum Priority: Int {
    case low, medium, high
    
    func getColor() -> UIColor {
        switch self {
        case .high:
            return .highPriority
        case .low:
            return .blueTodoieColor
        case .medium:
            return .medPriority
        }
    }
}
