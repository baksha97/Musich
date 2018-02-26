//
//  Protocols.swift
//  Musich
//
//  Created by Loaner on 2/25/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation

protocol Identifiable{
    var id: String? { get set }
}
protocol Dated {
    var date: Date {get set}
}
