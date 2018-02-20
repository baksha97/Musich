//
//  User.swift
//  MusichDemo
//
//  Created by Loaner on 2/20/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation
protocol Identifiable{
    var id: String? { get set }
}
struct FirebaseUser: Codable, Identifiable{
    var id: String? = "1234"
    var name = "travis"
}

