//
//  HomeViewViewModel.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/15/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

class HomeViewViewModel {
    
    // bindable user
    var user = Bindable<TodoieUser>()
    //bindable TaskViewModel array
    var dataArray = Bindable<[TaskViewModel]>()
    
    /**
     This function fetchs the user from firestore
     */
    func fetchUser() {
        NetworkManager.shared.fetchUser { [unowned self] (todoieUser, error) in
            DispatchQueue.main.async {
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
                self.user.value = todoieUser
            }
        }
    }
    
    /**
     This function fetchs the data from firestore and returns a TaskViewModel.
     */
    func fetchHomeViewData() {
        NetworkManager.shared.fetchHomeViewData(userCompletion: { (user, error) in
            DispatchQueue.main.async {
                self.handleFetchedUser(user: user, error: error)
            }
        }) { (todos, error) in
            DispatchQueue.main.async {
                self.handleFetchedTasks(todos: todos, error: error)
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
    fileprivate func handleFetchedTasks(todos: [Todo], error: Error?) {
        if let err = error {
            print(err.localizedDescription)
            return
        }
        
        // Converting the todos to a TaskViewModel
        let taskViewModel = todos.map({ (todo) -> TaskViewModel in
            return TaskViewModel(task: todo)
        })
        
        self.dataArray.value = taskViewModel
    }
}
