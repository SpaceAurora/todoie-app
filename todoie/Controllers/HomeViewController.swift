//
//  HomeViewController.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/2/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    fileprivate var user: TodoieUser?
    fileprivate let homeVM = HomeViewViewModel()
    
    // passing self as a delegate to get notified when the user presses the buttons
    fileprivate lazy var header = HeaderView(delegate: self)
    
    // Creating a tableview that takes a TaskViewModel as the dataArray and a Cell that implements A taskViewModel
    fileprivate let tableView = BaseTableViewController<TaskViewModel, GenericCell<TaskViewModel>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("user: ", Auth.auth().currentUser)
        if Auth.auth().currentUser == nil {
            present(LoginViewController(), animated: true)
        } else {
            // fetches the user
            homeVM.fetchUser()
        }
    }
}

//MARK:- HomeViewViewModel setup

extension HomeViewController {
    
    func setupObservers() {
        // binds the taskViewModel dataArray with the tableview dataarray
        homeVM.dataArray.bind { [unowned self] (tasksArray) in
            self.passData(tasksArray: tasksArray)
        }
        
        // binds the user and their img to the header view
        homeVM.user.bind { [unowned self]  (user) in
            self.user = user
            guard let url = user?.imageURL else { return }
            self.header.setImage(withUrl: url)
        }
    }
    
    // makes sure the data is not nil
    func passData(tasksArray: [TaskViewModel]?) {
        guard let tasks = tasksArray else { return }
        tableView.dataArray = tasks
    }
}

//MARK:- Header view confirming protocol

extension HomeViewController: HeaderViewProtocol {
    
    func addTask() {
        //TODO: implement buttons
    }
    
    func searchTask() {
        //TODO: implement buttons
    }
    
    func openProfile() {
        //TODO: implement buttons
    }
}

//MARK:- UISetup

extension HomeViewController {
    
    // Setup the UI for the HomeViewController
    func setupUI(){
        // adds the BaseTableViewController as a child for the HomeController
        addChild(tableView)
        // takes the view of the BaseTableViewController so we can add it as a subview
        let tableVCView = tableView.view!
        
        view.addSubview(header)
        view.addSubview(tableVCView)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.44),
            
            tableVCView.topAnchor.constraint(equalTo: header.bottomAnchor),
            tableVCView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableVCView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableVCView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
    
}

