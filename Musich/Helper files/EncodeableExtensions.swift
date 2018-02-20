//
//  EncodeableExtensions.swift
//  MusichDemo
//
//  Created by Loaner on 2/19/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation

enum MyError: Error {
    case encodingError
}

extension Encodable{
    
    func toJson(excluding keys: [String] = [String]()) throws -> [String: Any] {
        let objectData = try JSONEncoder().encode(self)
        ///will need future modification
        let jsonObject = try JSONSerialization.jsonObject(with: objectData, options: [])
        guard var json = jsonObject as? [String: Any] else {throw MyError.encodingError}
        
        for key in keys{
            json[key] = nil
        }
        
        return json
    }
}

