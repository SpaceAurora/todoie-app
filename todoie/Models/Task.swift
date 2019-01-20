//
//  Task.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/14/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation
import Firebase

class Task {

    var uid: String?
    let title: String
    let description: String
    let note: String
    let category: String
    let priority: Priority
    
    var time: Date?
    var alertTime: Date?
    
    // incase we decide to save images too
    let imageurl = ""
    
    init(document: [String: Any]) {
        title = document["title"] as? String ?? ""
        uid = document["uid"] as? String ?? ""
        description = document["description"] as? String ?? ""
        note = document["note"] as? String ?? ""
        category = document["category"] as? String ?? ""
        (time, alertTime) = Task.getTime(document: document)
        priority = Priority(rawValue: document["priority"] as? Int ?? 0) ?? .low
    }
    
    init(title: String, description: String, note: String, category: String, time: Date, alertTime: Date, priority: Priority) {
        self.title = title
        self.uid = UUID().uuidString
        self.description = description
        self.note = note
        self.category = category
        self.time = time
        self.alertTime = alertTime
        self.priority = priority
        
    }
    
    static func getTime(document: [String: Any]) -> (Date?, Date?) {
        let time = document["time"] as? Timestamp
        let alertTime = document["alerttime"] as? Timestamp
        return (time?.dateValue(), alertTime?.dateValue())
    }
    
    func toViewModel() -> TaskViewModel {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let currentTime = time != nil ? dateFormatter.string(from: time!) : ""
        return TaskViewModel(uid: uid ?? "", title: title, description: description, time: currentTime, priority: priority.getColor())
    }
}

extension Task: SaveOperationProtocol {
    
    func getDocument() -> [String: Any] {
        return [
            "uid": uid,
            "title": title,
            "description": description,
            "note": note,
            "priority": priority.rawValue,
            "category": category,
            "time": time,
            "alerttime": alertTime,
        ]
    }
    
    func getDocument(withUID id: String, withUrl url: String?) -> [String : Any] {
        return [
            "uid": uid,
            "title": title,
            "description": description,
            "note": note,
            "priority": priority.rawValue,
            "category": category,
            "time": time,
            "alerttime": alertTime,
            "url": url ?? ""
        ]
    }
}
