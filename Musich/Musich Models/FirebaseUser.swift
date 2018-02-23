//
//  User.swift
//  MusichDemo
//
//  Created by Loaner on 2/20/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation
protocol Identifiable{
    var id: String? { get set }
}
protocol Dated {
    var date: Date {get set}
}

struct FirebaseUser: Codable, Identifiable, Dated{
    var id: String?
    var name: String
    var displayName: String
    var email: String
    var date: Date
    var profilePictureURL: String
    var feedItems: [FeedItem]?
    
    init(id: String, name: String, displayName: String, email: String, date: Date, profilePictureURL: String, feedItems: [FeedItem]? ){
        self.id = id
        self.name = name
        self.displayName = displayName
        self.email = email
        self.date = date
        self.profilePictureURL = profilePictureURL
        self.feedItems = feedItems
    }
}
