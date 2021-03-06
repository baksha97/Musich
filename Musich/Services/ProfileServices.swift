//
//  ProfileServices.swift
//  Musich
//
//  Created by Loaner on 2/21/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation
import FirebaseFirestore

class ProfileServices{
    
    private init(){
        configureDateFormatter()
    }
    
    private func reference(to reference: FIRFirestoreReference) -> CollectionReference{
        return Firestore.firestore().collection(reference.description)
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
    
    //TODO: add ability to manage a follwers array
    func followUser(with id: String){
        appendFollowing(with: id)
        addToFollowerRoot(to: id, by: (currentFirebaseUser?.id)!)
    }
    //1:
    func appendFollowing(with id: String){
        print("adding new follower...")
        var user = currentFirebaseUser!
        if(user.following == nil){
            user.following = [String]()
            user.following?.append(id)
            print("adding new follower - nil append")
        }else{
            user.following!.append(id)
            print("adding new follower - append")
        }
        print("updating w new follower")
        FIRFirebaseService.shared.update(for: user, in: .users, merge: true)
    }
    //2:
    func addToFollowerRoot(to userID: String, by followerID: String){
       // reference(to: .followed).document(userID).setData([followerID: true])
        reference(to: .followed).document(userID)
            .collection("followers").document(followerID)
            .setData(["id": "followerID", "displayName": "dn"])
    }
    
    func getFollowers(for userID: String){
        reference(to: .followed).document(userID)
        .collection("followers").getDocuments(completion: {(snap, err) in
            
        })//.whereField(<#T##field: String##String#>, isEqualTo: <#T##Any#>)
    }

    
    private func configureDateFormatter(){
        self.formatter.dateStyle = .medium
        self.formatter.timeStyle = .none
        // self.formatter.locale = Locale(identifier)
    }
}

struct Following: Codable, Identifiable{
    var id: String? //following id
    var followerId: String?
}
