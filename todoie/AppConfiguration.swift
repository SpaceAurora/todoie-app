//
//  AppConfiguration.swift
//  todoie
//
//  Created by Mustafa Khalil on 12/12/18.
//  Copyright © 2018 Aurora. All rights reserved.
//

import Foundation

/**
 AppConfiguration holds all the important information about the application
*/
struct AppConfiguration {
    
    /**
     serverURL will return the debugURL or the productionURL.
     */
    static let serverUrl: URL = {
        #if DEBUG
        let url = URL(string: "https://powerful-reaches-68877.herokuapp.com")!
        print("Debug mode: \(url.absoluteString)")
        return url
        #else
        return URL(string: "https://powerful-reaches-68877.herokuapp.com")!
        #endif
    }()
}
