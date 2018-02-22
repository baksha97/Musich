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
//        FIRFirebaseService.shared.observeCurrentUser(completion: {(error) in
//            print(error.debugDescription)
//            print("observed current user")
//        })
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
            return formatter.string(from: currentFirebaseUser!.accountCreatedOn)
        }
        else{
            print("error getting value for cell data")
            return "ERROR"
        }
    }
    
    func updateCurrentUser(){
        FIRFirebaseService.shared.update(for: currentFirebaseUser!, in: .users, merge: true)
    }
    
    
    private func configureDateFormatter(){
        self.formatter.dateStyle = .medium
        self.formatter.timeStyle = .none
        // self.formatter.locale = Locale(identifier)
    }
}
