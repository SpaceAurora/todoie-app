//
//  HeaderViewProtocol.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/14/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation

// This Protocol should be implemented in every UIViewController that has the header view
protocol HeaderViewProtocol: class {
    /**
    Returns an event that the add button has been clicked
    */
    func addTask()
    /**
     Returns an event that the search button has been clicked
     */
    func searchTask()
    /**
     Returns an event that the profile button has been clicked
     */
    func openProfile()
}
