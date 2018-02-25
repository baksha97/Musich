//
//  FIRFirebaseService.swift
//  Musich
//
//  Created by Loaner on 2/19/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorageUI
import FirebaseFirestore

class FIRFirebaseService{
    
    private init(){}
    static let shared = FIRFirebaseService()
    
    
    private func reference(to reference: FIRRealTimeDatabaseReference) -> DatabaseReference{
        return Database.database().reference().child(reference.rawValue)
    }
    
    private func reference(to reference: FIRFirestoreReference) -> CollectionReference{
        return Firestore.firestore().collection(reference.description)
    }
    
    private func reference(to reference: FIRStorageReference) -> StorageReference{
        return Storage.storage().reference().child(reference.description)
    }
    
    func create<T: Encodable>(for encodableObject: T, in collectionReference: FIRFirestoreReference){
        do{
            let json = try encodableObject.toJson()
            reference(to: collectionReference).addDocument(data: json)
        } catch{
            print(error)
        }
    }
    
    func createDocument<T: Encodable & Identifiable>(for encodableObject: T, in collectionReference: FIRFirestoreReference){
        do{
            let json = try encodableObject.toJson()
            guard let id = encodableObject.id else{ throw MyError.encodingError}
            reference(to: collectionReference).document(id).setData(json)
        } catch{
            print(error)
        }
    }
    
    func storageSave(for image: UIImage, with id: String, in storageReference: FIRStorageReference, completion: @escaping(StorageMetadata, Error?) -> Void){
        let imageData = UIImageJPEGRepresentation(image, 0.1)
        reference(to: storageReference).child(id).putData(imageData!, metadata: nil, completion: { (metadata, err) in
            completion(metadata!,err)
        })
    }
    
    func read<T: Decodable>(from collectionReference: FIRFirestoreReference, returning objectType: T.Type, completion: @escaping([T]) -> Void){
        reference(to: collectionReference).addSnapshotListener { (snapshot, _) in
            guard let snapshot = snapshot else {return}
            do{
                var objects = [T]()
                for document in snapshot.documents{
                    let object = try document.decode(as: objectType.self)
                    objects.append(object)
                }
                completion(objects)
            } catch{
                print(error)
            }
        }
    }
    
    func readDatedObjects<T: Decodable & Dated>(from collectionReference: FIRFirestoreReference, order decending: Bool, returning objectType: T.Type, completion: @escaping([T]) -> Void){
        reference(to: collectionReference).order(by: "date", descending: decending).addSnapshotListener { (snapshot, _) in
            guard let snapshot = snapshot else {return}
            do{
                var objects = [T]()
                for document in snapshot.documents{
                    let object = try document.decode(as: objectType.self)
                    objects.append(object)
                }
                completion(objects)
            } catch{
                print(error)
            }
        }
    }
    
    func readDatedObjects<T: Decodable & Dated>(from collectionReference: FIRFirestoreReference, order decending: Bool, limited amount: Int, returning objectType: T.Type, completion: @escaping([T]) -> Void){
        reference(to: collectionReference).order(by: "date", descending: decending).limit(to: amount).addSnapshotListener { (snapshot, _) in
            guard let snapshot = snapshot else {return}
            do{
                var objects = [T]()
                for document in snapshot.documents{
                    let object = try document.decode(as: objectType.self)
                    objects.append(object)
                }
                completion(objects)
            } catch{
                print(error)
            }
        }
    }
    
    func retrieveDocument<T: Decodable>(from collectionReference: FIRFirestoreReference, with id: String, returning objectType: T.Type, completion: @escaping(T) -> Void){
        reference(to: collectionReference).document(id).getDocument(completion: { (document, error) in
            guard let document = document else {return}
            do{
                var object: T
                object = try document.decode(as: objectType.self)
                completion(object)
            } catch{
                print(error)
            }
        })
    }
    
    func update<T: Encodable & Identifiable>(for encodableObject: T, in collectionReference: FIRFirestoreReference, merge isMerge: Bool){
        do{
            let json = try encodableObject.toJson()
            guard let id = encodableObject.id else{ throw MyError.encodingError}
            if(isMerge){
                reference(to: collectionReference).document(id).setData(json, options: SetOptions.merge())
            } else{
                reference(to: collectionReference).document(id).setData(json)
            }
            
        }catch{
            print(error)
        }
    }
    
    func delete<T: Identifiable>(_ identifiableObject: T, in collectionReference: FIRFirestoreReference){
        do{
            guard let id = identifiableObject.id else {throw MyError.encodingError}
            reference(to: collectionReference).document(id).delete()
        }catch{
            print(error)
        }
    }
    
    //Exclusive Unique Methods
    
    func observeCurrentUser(completion: @escaping(Error?) -> Void){
        ///PULLING AUTH CURRENT USER
        reference(to: .users).document((Auth.auth().currentUser?.uid)!).addSnapshotListener{ (document, error) in
            guard let document = document else {return}
            do{
                let user = try document.decode(as: FirebaseUser.self)
                ProfileServices.shared.setCurrentUser(user: user)
                completion(error)
            } catch{
                print("error observing user")
                completion(error)
            }
        }
    }

    func createProfilePhotoURL(url: String, user id: String, in collectionReference: FIRFirestoreReference){
        reference(to: collectionReference).document(id).setData(["profilePhotoURL":url])
    }
    
    func getProfilePhoto(for id: String, completion: @escaping(UIImage?, Error?) -> Void){
        reference(to: .userProfilePhotoURLs).document(id).getDocument{ (doc, error) in
            if let doc = doc {
                //its a dict
                let imageLink = (doc.data()!["profilePhotoURL"] as! String)
                let imageURL = URL.init(string: imageLink)
                URLSession.shared.dataTask(with: imageURL!, completionHandler: { (data, response, error) in
                    if error == nil {
                        let image = UIImage.init(data: data!)
                        completion(image, nil)
                    }else{
                        completion(nil, error)
                    }
                }).resume()
            } else{
                print("failure getting profile photo")
            }
        }
    }
    
    func setImageView(view imageView: UIImageView, with id: String){
        imageView.sd_setImage(with: reference(to: .usersProfilePictures).child(id), placeholderImage: UIImage(named:"loading"))
    }
    
    //temp todo - find ALT for profile pic on pro page.
    func setupProfileImageView(view imageView: UIImageView){
        getProfilePhoto(for: (ProfileServices.shared.currentFirebaseUser?.id!)!, completion: {(image, _) in
            if image != nil {
                DispatchQueue.main.async(){
                    imageView.image = image
                }
            }
            else{
                print("error getting profile pic")
            }
        })
    }
    
    //Configuration
    func configure(){
        FirebaseApp.configure()
    }
}


