//
//  UIElements.swift
//  Musich
//
//  Created by Loaner on 2/9/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialThemes

struct UIElements {

    public var colorScheme: MDCBasicColorScheme = {
        let colorScheme = MDCBasicColorScheme(primaryColor: UIColor.init(white: 0.2, alpha: 1),
                                              primaryLightColor: .init(white: 0.7, alpha: 1),
                                              primaryDarkColor: .init(white: 0, alpha: 1))
        return colorScheme
    }()
    
    
    
}
