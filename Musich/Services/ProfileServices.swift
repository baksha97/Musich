//
//  ProfileServices.swift
//  Musich
//
//  Created by Loaner on 2/21/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation

class ProfileServices{
    
    private init(){
        configureDateFormatter()
    }
    
    static let shared = ProfileServices()
    let formatter = DateFormatter()
    var currentFirebaseUser: FirebaseUser?
    //Settings View Constants
    private var displayText = ["Name:","Display name:", "Email:", "Created on:"]
    
    func performAction(for indexPath: Int){
        
    }
    
    func dataCount() -> Int{
        return self.displayText.count
    }
    
    func getDisplayText(for index: Int) -> String{
        return displayText[index]
    }
    
    func setCurrentUser(user: FirebaseUser){
        self.currentFirebaseUser = user
    }
    
    func getCurrentUserValue(for data: String) -> String{
        if(data == "Name:"){
            return currentFirebaseUser!.name
        }
        else if(data == "Display name:"){
            return currentFirebaseUser!.displayName
        }
        else if(data == "Email:"){
            return currentFirebaseUser!.email
        }
        else if(data == "Created on:"){
            configureDateFormatter()
            return formatter.string(from: currentFirebaseUser!.date)
        }
        else{
            print("error getting value for cell data")
            return "ERROR"
        }
    }
    
    func addFeedItem(feedItem: FeedItem){
        print("publishing...")
        var user = currentFirebaseUser!
        if(user.feedItems == nil){
            user.feedItems = [FeedItem]()
            user.feedItems?.append(feedItem)
            print("publishing - nil append")
        }else{
            
            user.feedItems!.append(feedItem)
            print("publishing - append")
        }
        print("updating w publish")
        FIRFirebaseService.shared.update(for: user, in: .users, merge: true)
    }
    
    func observeCurrentUser(){
        FIRFirebaseService.shared.observeCurrentUser(completion: {(error) in
            print(error.debugDescription)
            print("observed current user")
        })
    }
    
    private func configureDateFormatter(){
        self.formatter.dateStyle = .medium
        self.formatter.timeStyle = .none
        // self.formatter.locale = Locale(identifier)
    }
}
