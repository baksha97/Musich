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
    var userID: String?
    var userName: String
    var song: String
    var description: String
    var date: Date
    
    init(userID: String, userName: String, song: String, description: String, date: Date) {
        self.userID = userID
        self.userName = userName
        self.song = song
        self.description = description
        self.date = date
    }
    
    //only to public sector... if you want to add feed items to your own personal feed, we would need to update the FirebaseUser object... so ideally we'd be using a combination of this and the update method when a user listens to a new song.
    func pushFeedItem(){
        FIRFirebaseService.shared.create(for: self, in: .publicFeedItems)
    }
}
