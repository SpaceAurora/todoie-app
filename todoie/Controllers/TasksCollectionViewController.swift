//
//  TasksCollectionViewController.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/14/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

class TasksCollectionViewController: UICollectionViewController {
    
    // cell to be used
    private let cellID = "todo-cell"
    private weak var delegate: TasksCollectionViewControllerDelegate?
    
    // dataArray that's generic to the type of the class
    var dataArray: [TaskViewModel] = [] {
        didSet {
            // if the data is set, we will refresh
            collectionView.reloadData()
        }
    }
    
    init(collectionViewLayout layout: UICollectionViewLayout, delegate: TasksCollectionViewControllerDelegate) {
        self.delegate = delegate
        super.init(collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.prefetchDataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- CollectionView methods

extension TasksCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TaskCell
        cell.data = dataArray[indexPath.item]
        return cell
    }
    
}

//MARK:- prefetching

extension TasksCollectionViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        delegate?.prefetchElements(indexPaths: indexPaths)
    }
}

//MARK:- UI

extension TasksCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
