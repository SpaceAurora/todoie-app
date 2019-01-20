//
//  TasksViewModels.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/15/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

struct TaskViewModel {
    let uid: String
    let title: String
    let description: String
    let time: String
    let priority: UIColor
}


extension TaskViewModel: Equatable {
    static func == (lhs: TaskViewModel, rhs: TaskViewModel) -> Bool {
        return lhs.uid == lhs.uid
    }
}
