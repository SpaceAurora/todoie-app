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
    
    static var dateMonthYearFormat: String {
        return "YYYY-dd-MM"
    }
    
    static var timeFormat: String {
        return "h:mm a"
    }
    
    static var alertFormat: String {
        return "E, MM/d/yyyy, h:mm a"
    }
    
    static var serverDateFormat: String {
        return "YYYY-dd-MM 'at' h:mm a"
    }
    
    
    func getDate(withFormat format: String) -> String {
        var dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: self)
    }
    
    static func getDateFromString(_ date: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: date)
    }
}

