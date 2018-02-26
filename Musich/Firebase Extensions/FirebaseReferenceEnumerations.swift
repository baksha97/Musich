//
//  FirebaseEnumerations.swift
//  Musich
//
//  Created by Loaner on 2/25/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation

enum FIRRealTimeDatabaseReference: String{
    case users
}

enum FIRFirestoreReference : CustomStringConvertible {
    case users
    case userProfilePhotoURLs
    case publicFeedItems
    case followed
    
    var description : String {
        switch self {
            case .users: return "users"
            case .userProfilePhotoURLs: return "userProfilePhotoURLs"
            case .publicFeedItems: return "publicFeedItems"
            case .followed: return "followed"
        }
    }
}

enum FIRStorageReference : CustomStringConvertible {
    case usersProfilePictures
    
    var description : String {
        switch self {
        case .usersProfilePictures: return "usersProfilePictures"
        }
    }
}
