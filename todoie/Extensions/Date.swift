//
//  Date.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/19/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation

extension Date {
    
    var startOfDay : Date {
        return Calendar(identifier: .gregorian).startOfDay(for: Date())
    }
    
    var endOfDay : Date {
        var components = DateComponents()
        components.day = 1
        let date = Calendar.current.date(byAdding: components, to: self.startOfDay)
        return (date?.addingTimeInterval(0))!
    }
}

