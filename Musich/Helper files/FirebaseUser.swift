//
//  User.swift
//  Musich
//
//  Created by Loaner on 2/20/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation
protocol Identifiable{
    var id: String? { get set }
}
struct FirebaseUser: Codable, Identifiable{
    var id: String?
    var name: String
    var displayName: String
    var email: String
    var profilePictureURL: String
    var feedItems: [FeedItem]?
    
    init(id: String, name: String, displayName: String, email: String, profilePictureURL: String, feedItems: [FeedItem]?){
        self.id = id
        self.name = name
        self.displayName = displayName
        self.email = email
        self.profilePictureURL = profilePictureURL
        self.feedItems = feedItems
    }
}

struct FeedItem: Codable{
    var song: String
    var description: String
    
    init(song: String, description: String) {
        self.song = song
        self.description = description
    }
}
