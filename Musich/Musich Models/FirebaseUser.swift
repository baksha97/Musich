//
//  User.swift
//  MusichDemo
//
//  Created by Loaner on 2/20/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation

struct FirebaseUser: Codable, Identifiable, Dated{
    var id: String?
    var name: String
    var displayName: String
    var email: String
    var date: Date
    var profilePictureURL: String
    var following: [String]?
    var feedItems: [FeedItem]?
    
    init(id: String, name: String, displayName: String, email: String, date: Date, profilePictureURL: String, following: [String]?, feedItems: [FeedItem]? ){
        self.id = id
        self.name = name
        self.displayName = displayName
        self.email = email
        self.date = date
        self.profilePictureURL = profilePictureURL
        self.following = following
        self.feedItems = feedItems
    }
}
