//
//  TodoieUser.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/3/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation
import GoogleSignIn

struct TodoieUser {
    let firstName: String
    let lastName: String
    let email: String
    
    init(facebookUser: [String: Any] ) {
        firstName = facebookUser["first_name"] as? String ?? ""
        lastName = facebookUser["last_name"]  as? String ?? ""
        email = facebookUser["email"]  as? String ?? ""
    }
    
    init(googleUser: GIDGoogleUser) {
        firstName = googleUser.profile.givenName
        lastName = googleUser.profile.familyName
        email = googleUser.profile.email
        
    }
}
