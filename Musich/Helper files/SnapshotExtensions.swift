//
//  SnapshotExtensions.swift
//  MusichDemo
//
//  Created by Loaner on 2/20/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension DocumentSnapshot{
    
    func decode<T: Decodable>(as objectType: T.Type, including_ID_Example: Bool = true) throws -> T{
        
        var documentJson = data()!
        if including_ID_Example{
            documentJson["id"] = documentID
        }
        
        let documentData = try JSONSerialization.data(withJSONObject: documentJson, options: [])
        let decodedObject = try JSONDecoder().decode(objectType, from: documentData)
        
        return decodedObject
    }
}

