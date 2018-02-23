//
//  MDCAlertService.swift
//  Musich
//
//  Created by Loaner on 2/22/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import MaterialComponents.MaterialDialogs

class MDCAlertService{
    private init(){}
    
    static let shared = MDCAlertService()
    //var dialogTransitionController: MDCDialogTransitionController
    var materialAlertController: MDCAlertController?
    //materialAlertController!.dismiss(animated: true, completion: nil)
    
    func okAlert(sender: UIViewController, title: String, message: String){
        materialAlertController = MDCAlertController(title: title, message: message)
        let action = MDCAlertAction(title:"OK") { (_) in print("OK") }
        materialAlertController!.addAction(action)
        sender.present(materialAlertController!, animated: true, completion: nil)
    }
    
//    func pendingCloseAlert(sender: UIViewController, title: String, message: String){
//        materialAlertController = MDCAlertController(title: title, message: message)
//        sender.present(materialAlertController!, animated: true, completion: nil)
//    }
    
}

