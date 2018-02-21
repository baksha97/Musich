//
//  FIRFirebaseService.swift
//  Musich
//
//  Created by Loaner on 2/19/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation
import Firebase
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
        return Storage.storage().reference().child(reference.description)///TODO ?
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
    
    
    func configure(){
        FirebaseApp.configure()
    }
}

enum FIRRealTimeDatabaseReference: String{
    case users
    case temp
}

enum FIRFirestoreReference : CustomStringConvertible {
    case users
    
    var description : String {
        switch self {
        case .users: return "users"
        }
    }
}

enum FIRStorageReference : CustomStringConvertible {
    case usersProfilePictures
    
    var description : String {
        switch self {
        case .usersProfilePictures: return "usersProfilePictures"
        }
    }
}
