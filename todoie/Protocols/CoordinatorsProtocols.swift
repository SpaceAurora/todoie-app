//
//  AddTaskViewControllerCoordinatorDelegate.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/25/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

protocol CoordinatorDelegate: class {
    
    func dismissFromMainView(controller: UIViewController)
    
    func showWelcomingViewController(controller: UIViewController)
    
    func showAddTasksViewController(controller: UIViewController)
    
    func showSearchViewController(controller: UIViewController)
    
    func showProfileViewController(controller: UIViewController)
    
}

