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
    
    //LOGIN
    func loginUser(withEmail: String, password: String, completion: @escaping(Bool, Error?)-> Void){
        Auth.auth().signIn(withEmail: withEmail, password: password, completion: { (user, error) in
            if error == nil {
                //TODO - CONFIGURE USER DEFAULTS PROPERLY
                // let userInfo = ["email": withEmail, "password": password]
                //  UserDefaults.standard.set(userInfo, forKey: "userInformation")
                FIRFirebaseService.shared.observeCurrentUser(completion: {(error) in
                    if error == nil{
                        print("observing user")
                        completion(true, error)
                    }
                    else{
                        print("observing failed")
                        completion(false, error)
                    }
                })
            } else {
                completion(false, error)
                print(error.debugDescription)
            }
        })
    }
    
    //REGISTRATION METHODS
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
        FIRFirebaseService.shared.storageSave(for: pickedImage, with: authCurrentUser().uid, in: .usersProfilePictures, completion:{ (metadata, err) in
            if err == nil{
                let path = metadata.downloadURL()?.absoluteString
                //add profilephotourl to a public collection
                FIRFirebaseService.shared.createProfilePhotoURL(url: path!, user: self.authCurrentUser().uid, in: .userProfilePhotoURLs)
                //instansiate FirebaseUser object with photo url and push their personal data...
                self.instansiateFirebaseUser(name: name, displayName: displayName, path: path!)
            }
            else{
                print("ERROR STORING PHOTO")
            }
        })
    }
    
    //step three - completed
    private func instansiateFirebaseUser(name: String, displayName: String, path: String){
        let user: FirebaseUser = FirebaseUser(id: authCurrentUser().uid, name: name, displayName: displayName, email: authCurrentUser().email!, date: Date(), profilePictureURL: path, feedItems: nil)
        FIRFirebaseService.shared.createDocument(for: user, in: .users)
    }
    
}
