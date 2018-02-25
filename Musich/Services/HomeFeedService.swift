//
//  HomeFeedService.swift
//  Musich
//
//  Created by Loaner on 2/25/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation
import FirebaseFirestore

class HomeFeedService{
    private init(){
     //   start()
    }
    
    static let shared = HomeFeedService()
    
    var feedItems = [FeedItem]()
    
    var queryCompletions = [Bool]()
    
    private func reference(to reference: FIRFirestoreReference) -> CollectionReference{
        return Firestore.firestore().collection(reference.description)
    }
    
    //TODO: Make clearer and dynamic----------
    
    //Home Feed Page
//    func start(){
//        //readFeedItems()
//    }
    
    
    func getCurrentUserFollowerQueries() -> [Query]?{
        
        var queries = [Query]()
        
        if let following = ProfileServices.shared.currentFirebaseUser?.following {
            let follwerQuery = reference(to: .publicFeedItems)
               // .order(by: "date", descending: false)
               // .limit(to: 5) //set amount to show on your feed per each person
            
            for (index, _) in following.enumerated(){
                queries.append(follwerQuery.whereField("userID", isEqualTo: following[index]).order(by: "date", descending: true).limit(to: 5))
            }
            print("quer amount = \(queries.count)")
            return queries
        }else{
            return nil
        }
    }
    
    func readFeedItems(completion: @escaping (Bool) -> Void) -> Void{
        //reset current items
        queryCompletions = [Bool]()
        feedItems = [FeedItem]()
        //start
        if let queries = getCurrentUserFollowerQueries(){
            for (i, query) in queries.enumerated(){
                //TODO: figure out if it's better to add a snapshot of this or add a refresh button.... seems like a very expensive operation operation if users are constantly listening...
                query.addSnapshotListener { (snapshot, error) in
                    print("Query ...\(i)")
                    guard let snapshot = snapshot else{print("snapshot == nil"); return;}
                    //^prints at times... not sure why... possiblity due to dummy data
                    do{
                        for document in snapshot.documents{
                            let object = try document.decode(as: FeedItem.self)
                            self.feedItems.append(object)
                            print(self.feedItems.count)
                        }
                    } catch{
                        print(error)
                    }
                    self.queryCompletions.append(true)
                    if self.queryCompletions.count == queries.count{
                        completion(true)
                    }
                }
            }
        }
        else{
            print("Follower Queries are empty.")
            completion(false)
        }
    }
    
    
    
}
