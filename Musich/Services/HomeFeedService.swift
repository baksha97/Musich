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
    private init(){}
    
    static let shared = HomeFeedService()
    
    var feedItems = [FeedItem]()
    
    var queryCompletions = [Bool]()
    
    private func reference(to reference: FIRFirestoreReference) -> CollectionReference{
        return Firestore.firestore().collection(reference.description)
    }
    
    //TODO: Make clearer and dynamic----------
    
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
    
//TRYING TO DEBUG WHY ITS PRINTING NIL FOR EXTRA SNAPSHOTS???
    func readFeedItems(completion: @escaping (Bool) -> Void) -> Void{
        //reset current items
        queryCompletions = [Bool]()
        feedItems = [FeedItem]()
        //start
        if let queries = getCurrentUserFollowerQueries(){
            for (i, query) in queries.enumerated(){
                //TODO: figure out if it's better/how to add a snapshot of this or add a refresh button.... seems like a very expensive operation operation if users are constantly listening...
                query.addSnapshotListener { (snapshot, error) in
                    print("Query ...#\(i)");
                    guard let snapshot = snapshot else{
                        print("snapshot == nil"); //reprints for each query...
                        return;
                    }
                    //^REprints queries runs...
                    //the class does NOT instantiate more than once
                    //the loop does not run more than set
                    //IT HAS TO be something within the listener method itself.
                    
                    
                    do{
                        for document in snapshot.documents{
                            let object = try document.decode(as: FeedItem.self)
                            self.feedItems.append(object)
                            print(self.feedItems.count)
                        }
                        self.queryCompletions.append(true)
                    } catch{
                        print(error)
                    }
                    
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
