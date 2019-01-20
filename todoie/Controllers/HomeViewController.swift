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
    
    // constants
    fileprivate let homeVM = HomeViewModel()
    
    // vars
    fileprivate var user: TodoieUser?
    
    // UIComponents
    // passing self as a delegate to get notified when the user presses the buttons
    fileprivate lazy var header = HeaderView(delegate: self)
    fileprivate let spinner: UIActivityIndicatorView = {
        let s = UIActivityIndicatorView(style: .gray)
        s.translatesAutoresizingMaskIntoConstraints = false
        s.hidesWhenStopped = true
        return s
    }()
    
    // Creating a collectionView that takes a TaskViewModel as the dataArray and a Cell that implements A taskViewModel
    fileprivate lazy var collectionView = TasksCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout(), delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        spinner.startAnimating()
        homeVM.fetchHomeViewData()
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
        spinner.stopAnimating()
        guard let tasks = tasksArray else { return }
        collectionView.dataArray = tasks
    }
}

extension HomeViewController: TasksCollectionViewControllerDelegate {
    
    func prefetchElements(indexPaths: [IndexPath]) {
        homeVM.prefetchingTasks(indexPaths: indexPaths)
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
        addChild(collectionView)
        // takes the view of the BaseTableViewController so we can add it as a subview
        let collectionVCView = collectionView.view!
        let line = LineView()
        
        // insert views
        view.addSubview(line)
        view.addSubview(spinner)
        view.insertSubview(header, aboveSubview: line)
        view.insertSubview(collectionVCView, aboveSubview: line)
        line.setupView(leadingAnchor: view.leadingAnchor)
        
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.44),
            
            collectionVCView.topAnchor.constraint(equalTo: header.bottomAnchor),
            collectionVCView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionVCView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionVCView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: collectionVCView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: collectionVCView.centerYAnchor),
            
            line.topAnchor.constraint(equalTo: view.topAnchor),
            line.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
}

