//
//  BaseTableViewController.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/14/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

// Class to Extent on for our cells
class GenericCell<T>: UITableViewCell {
    var data: T!
}

// Base Class for the tableView

class BaseTableViewController<T, U: GenericCell<T>>: UITableViewController {
    
    // cell to be used
    private let cellID = "todo-cell"
    // dataArray that's generic to the type of the class
    var dataArray: [T] = [] {
        didSet {
            // if the data is set, we will refresh
            tableView.reloadData()
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .red // should be removed
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // registering the generic Cell u to the table view by the cellid
        tableView.register(U.self, forCellReuseIdentifier: cellID)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! U
        cell.data = dataArray[indexPath.item]
        return cell
    }
}
