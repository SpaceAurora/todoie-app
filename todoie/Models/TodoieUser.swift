//
//  TodoieUser.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/3/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

class TodoieUser: SaveOperationProtocol {
    
    let firstName: String
    let lastName: String
    let email: String
    let imageURL: String
    var uid: String?
    
    // Todoie user
    init(firestore: [String: Any]) {
        firstName = firestore["firstName"] as? String ?? ""
        lastName = firestore["lastName"]  as? String ?? ""
        email = firestore["email"]  as? String ?? ""
        imageURL = firestore["profileImageURL"] as? String ?? ""
        uid = firestore["uid"] as? String ?? ""
    }
    
    // User from facebook
    init(facebookUser: [String: Any] ) {
        firstName = facebookUser["first_name"] as? String ?? ""
        lastName = facebookUser["last_name"]  as? String ?? ""
        email = facebookUser["email"]  as? String ?? ""
        imageURL = TodoieUser.getImageURLForFacebookUsers(id: facebookUser["id"] as? String ?? "")
        uid = nil
    }
    
    // User from google
    init(googleUser: GIDGoogleUser) {
        firstName = googleUser.profile.givenName
        lastName = googleUser.profile.familyName
        email = googleUser.profile.email
        imageURL = TodoieUser.getImageURLFromGoogleUser(googleUser)
        uid = nil
    }
    
    // Prepares the image according to facebook's url
    static func getImageURLForFacebookUsers(id: String) -> String {
        if id.isEmpty {
            return ""
        }
        return "https://graph.facebook.com/\(id)/picture?type=large&redirect=true&width=500&height=500"
    }
    
    // gets the image url from google
    static func getImageURLFromGoogleUser(_ googleUser: GIDGoogleUser) -> String {
        let dimension = UInt(round(100 * UIScreen.main.scale))
        let picUrl = googleUser.profile.imageURL(withDimension: dimension)
        guard let url = picUrl?.absoluteString else { return "" }
        return url
    }
    
    func getDocument() -> [String : Any] {
        return ["":""]
    }
    
    func getDocument(withUID id: String, withUrl url: String?) -> [String: Any] {
        uid = id
        return [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "uid": uid ?? "",
            "profileImageURL": url ?? "",
            "timestamp": Int(Date().timeIntervalSince1970)
        ]
    }
}
