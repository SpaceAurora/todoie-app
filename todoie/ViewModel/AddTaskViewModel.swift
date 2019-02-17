//
//  AddTaskViewModel.swift
//  todoie
//
//  Created by Mustafa Khalil on 2/11/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation
import Firebase

class AddTaskViewModel {
    
    var uploaded = Bindable<Bool>()
    var error = Bindable<Bool>()
    var title: String?
    var descrption: String?
    var calender: Date?
    var time: Date?
    var alert: Date?
    var priority: Priority?
    
    func save() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.uploaded.value = false
        
        let date = getTaskDateFromStrings()
        NetworkManager.shared.saveTask(uid: uid, task: Task(title: title ?? "", description: descrption ?? "", note: "", category: "", time: date ?? Date(), alertTime: alert ?? Date(), priority: priority ?? .low)) { (isDone, error) in
            
            if let err = error {
                // Handle error
                print(err)
                self.error.value = true
                return
            }
            self.uploaded.value = true
            
        }
    }
    
    func getTaskDateFromStrings() -> Date? {
        let calText = calender?.getDate(withFormat: Date.dateMonthYearFormat) ?? Date().getDate(withFormat: Date.dateMonthYearFormat)
        let timeText = time?.getDate(withFormat: Date.timeFormat) ?? Date().getDate(withFormat: Date.timeFormat)
        return Date.getDateFromString("\(calText) at \(timeText)", format: Date.serverDateFormat)
    }
}
