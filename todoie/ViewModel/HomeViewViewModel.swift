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
            if let err = error {
                print(err.localizedDescription)
                return
            }
            self.user.value = todoieUser
        }
    }
    
    /**
     This function fetchs the data from firestore and returns a TaskViewModel.
     */
    func fetchTasks() {
        //TODO: implement fetching the tasks from firestore
    }
}
