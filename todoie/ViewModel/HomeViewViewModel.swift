//
//  HomeViewViewModel.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/15/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit
import Firebase

class HomeViewViewModel {
    
    private let limit = 15
    
    var tasksArray: [Task] = []
    
    var fetchingIndex: [IndexPath: TaskViewModel] = [:]
    // bindable user
    var user = Bindable<TodoieUser>()
    //bindable TaskViewModel array
    var dataArray = Bindable<[TaskViewModel]>()
    
    /**
     This function handles prefetching from firestore
     */
    func prefetchingTasks(indexPaths: [IndexPath]) {
        
        // gets the last index of the prefetching array
        guard let last = indexPaths.last else { return }
        // checks the last index with the view model that represents that indexPath
        if let lastUid = dataArray.value?.last?.uid, let currentUid = dataArray.value?[last.item].uid, lastUid != currentUid {
            return
        }
        // if we already fetched it we skip
        if let _ = fetchingIndex[last] {
            return
        }
        // setting the fetching to true
        fetchingIndex[last] = dataArray.value?.last
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // prefetches the tasks
        NetworkManager.shared.fetchTasks(query: fetchTasksOrderedByTime(withUid: uid, lastFetched: tasksArray.last?.time, limit: limit)) { (tasks, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            let tasksVM = tasks.map({ (task) -> TaskViewModel in
                return task.toViewModel()
            })
            self.tasksArray.append(contentsOf: tasks)
            self.dataArray.value?.append(contentsOf: tasksVM)
        }
    }
    
    /**
     This function fetchs the data from firestore and returns a TaskViewModel.
     */
    func fetchHomeViewData() {
        // gets the uid of the current user to construct the query
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        NetworkManager.shared.fetchHomeViewData(query: fetchTasksOrderedByTime(withUid: uid, lastFetched: nil, limit: limit), userCompletion: { (user, error) in
            DispatchQueue.main.async {
                self.handleFetchedUser(user: user, error: error)
            }
        }) { (tasks, error) in
            DispatchQueue.main.async {
                self.handleFetchedTasks(tasks: tasks, error: error)
            }
        }
    }
    
    // Invokes the user bindable after checking for errors
    fileprivate func handleFetchedUser(user: TodoieUser?, error: Error?) {
        if let err = error {
            print(err.localizedDescription)
            return
        }
        self.user.value = user
    }
    
    // Invokes the dataArray bindable after checking for errors
    fileprivate func handleFetchedTasks(tasks: [Task], error: Error?) {
        if let err = error {
            print(err.localizedDescription)
            self.dataArray.value = []
            return
        }
        
        // Converting the tasks to a TaskViewModel
        let taskViewModel = tasks.map({ (task) -> TaskViewModel in
            return task.toViewModel()
        })
        self.tasksArray = tasks
        self.dataArray.value = taskViewModel
    }
    
    // Constructs the query that will be sent to firebase
    fileprivate func fetchTasksOrderedByTime(withUid uid: String, lastFetched: Date?, limit: Int) -> Query {
        return Query.fetchTasksOrderedByTime(userUID: uid, lastFetched: lastFetched, limit: limit)
    }
    
}
