//
//  Query.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/18/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Firebase

enum OrderBy: String {
    case time, uid
}

extension Query {
    
    /**
     fetch tasks according the order of the uid with a limit and a paganation
     - Parameters:
        - userUID: uid of the user logged in
        - startDate: the order of the items that will be pulled from the database
        - endDate: the order of the items that will be pulled from the database
        - lastFetched: the last fetched uid
        - limit: the limit of the paganation
     */
    static func fetchTasksOrderedByTime(userUID: String, startDate: Date = Date().startOfDay, endDate: Date = Date().endOfDay, lastFetched: Date?, limit: Int) -> Query {
        let timeOrder = OrderBy.time.rawValue
        let userTasksPath = FirebaseCalls.UserTasks.rawValue
        let tasksPath = FirebaseCalls.Tasks.rawValue
        return Firestore.firestore().collection(tasksPath).document(userUID)
            .collection(userTasksPath)
            .whereField(timeOrder, isGreaterThanOrEqualTo: startDate)
            .whereField(timeOrder, isLessThanOrEqualTo: endDate)
            .order(by: timeOrder, descending: true)
            .order(by: OrderBy.uid.rawValue, descending: true)
            .start(after: [lastFetched ?? endDate])
            .limit(to: limit)
    }
        
    /**
     fetch tasks according the order of the uid with a limit and a paganation
     - Parameters:
        - userUID: uid of the user logged in
        - lastFetched: the last fetched uid
        - limit: the limit of the paganation
     */
    static func fetchTasksOrderedByUID(userUID: String, lastFetched: String?, limit: Int) -> Query {
        let uidOrder = OrderBy.uid.rawValue
        let userTasksPath = FirebaseCalls.UserTasks.rawValue
        let tasksPath = FirebaseCalls.Tasks.rawValue
        return Firestore.firestore().collection(tasksPath).document(userUID)
            .collection(userTasksPath)
            .order(by: uidOrder)
            .start(after: [lastFetched ?? ""])
            .limit(to: limit)
    }
    
}

extension CollectionReference {
    
    /**
     SaveTask returns a refrence value to the collection where the task will be saved
     - Parameters:
        - userUID: the uid of the user in the collections
     */
    static func saveTask(userUID: String) -> CollectionReference {
        return Firestore.firestore().collection(FirebaseCalls.Tasks.rawValue).document(userUID).collection(FirebaseCalls.UserTasks.rawValue)
    }
    
    /**
     SaveUser returns a refrence value to the collection where the user will be saved
     */
    static func saveUser() -> CollectionReference {
        return Firestore.firestore().collection(FirebaseCalls.Users.rawValue)
    }
}
