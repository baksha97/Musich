//
//  FeedItem.swift
//  Musich
//
//  Created by Loaner on 2/22/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation

struct FeedItem: Codable, Dated{
    var userID: String?
    var userName: String
    var song: String
    var artist: String
    var album: String
    var date: Date
    
    init(userID: String, userName: String, song: String, artist: String, album: String, date: Date) {
        self.userID = userID
        self.userName = userName
        self.song = song
        self.artist = artist
        self.album = album
        self.date = date
    }
    
    //only to public sector... if you want to add feed items to your own personal feed, we would need to update the FirebaseUser object... so ideally we'd be using a combination of this and the update method when a user listens to a new song.
    func publishPublicly(){
        FIRFirebaseService.shared.create(for: self, in: .publicFeedItems)
    }
}
