//
//  RegistrationService.swift
//  MusichDemo
//
//  Created by Loaner on 2/20/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation
import Firebase

class UserRegistrationService{
    
    private init(){}
    static let shared = UserRegistrationService()
    
    
    private func authCurrentUser() -> Firebase.User{
        return Auth.auth().currentUser!
    }
    
    //step one
    func registerUser(email: String, password: String, name: String, displayName: String, pickedImage: UIImage){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil{
                self.uploadProfilePhoto(name: name, displayName: displayName, pickedImage: pickedImage)
            }else{
                print("THERE WAS AN ERROR CREATING USER")
            }
        }
    }
    
    //step two
    private func uploadProfilePhoto(name: String, displayName: String, pickedImage: UIImage){
        //func storageSave(for image: pickedImage, in storageReference: ., completion:
        FIRFirebaseService.shared.storageSave(for: pickedImage, with: authCurrentUser().uid, in: .usersProfilePictures, completion:{ (metadata, err) in
            if err == nil{
                let path = metadata.downloadURL()?.absoluteString
                //instansiate FirebaseUser object with photo url...
                self.instansiateFirebaseUser(name: name, displayName: displayName, path: path!)
            }
            else{
                print("ERROR STORING PHOTO")
            }
        })
    }
    
    //step three - completed
    private func instansiateFirebaseUser(name: String, displayName: String, path: String){
        let user: FirebaseUser = FirebaseUser(id: authCurrentUser().uid, name: name, displayName: displayName, email: authCurrentUser().email!, accountCreatedOn: Date(), profilePictureURL: path, feedItems: nil)
        FIRFirebaseService.shared.createDocument(for: user, in: .users)
    }
    
}
