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
struct FirebaseUser: Codable, Identifiable{
    var id: String?
    var name: String
    var displayName: String
    var email: String
    var accountCreatedOn: Date
    var profilePictureURL: String
    var feedItems: [FeedItem]?
    
    init(id: String, name: String, displayName: String, email: String, accountCreatedOn: Date, profilePictureURL: String, feedItems: [FeedItem]? ){
        self.id = id
        self.name = name
        self.displayName = displayName
        self.email = email
        self.accountCreatedOn = accountCreatedOn
        self.profilePictureURL = profilePictureURL
        self.feedItems = feedItems
    }
    
    //you won't be adding feed items, instead you'll be constantly "FIR.updating" the entire profile update
    //    func addFeedItems(feedItems: [FeedItem]){
    //        FIRFirebaseService.shared.update(for: feedItems, in: .feedItems)
    //    }
}


struct FeedItem: Codable{
    var song: String
    var description: String
    var date: Date
    
    init(song: String, description: String, date: Date) {
        self.song = song
        self.description = description
        self.date = date
    }
}

