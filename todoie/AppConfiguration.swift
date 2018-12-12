//
//  AppConfiguration.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/12/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import Foundation

struct AppConfiguration {
    static let serverUrl: URL = {
        #if DEBUG
        let url = URL(string: "https://powerful-reaches-68877.herokuapp.com")!
        return url
        #else
        return URL(string: "https://powerful-reaches-68877.herokuapp.com")!
        #endif
    }()
}
