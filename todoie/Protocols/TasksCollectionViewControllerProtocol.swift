//
//  TasksCollectionViewControllerProtocol.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/18/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation

protocol TasksCollectionViewControllerDelegate: class {
    func prefetchElements(indexPaths: [IndexPath])
}
