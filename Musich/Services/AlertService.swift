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

class AlertService{
    private init(){}
    
    static let shared = AlertService()
    //var dialogTransitionController: MDCDialogTransitionController
    var materialAlertController: MDCAlertController?
    //materialAlertController!.dismiss(animated: true, completion: nil)
    
    func okAlert(sender: UIViewController, title: String, message: String){
        materialAlertController = MDCAlertController(title: title, message: message)
        let action = MDCAlertAction(title:"OK") { (_) in print("OK") }
        materialAlertController!.addAction(action)
        sender.present(materialAlertController!, animated: true, completion: nil)
    }
    
    func requestNativeAlertInput(sender: UIViewController,
                                 title: String, message: String, completion: @escaping(String?)-> Void){
       let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addTextField { (textField) in
            textField.placeholder = "Enter here"
            textField.isSecureTextEntry = false
        }
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: {
            (alert) -> Void in
            
            if let text = (alertVC.textFields![0] as UITextField).text{
                completion(text)
            }
            else{
                completion(nil)
            }
        })
        alertVC.addAction(submitAction)
        alertVC.view.tintColor = UIColor.black
        sender.present(alertVC, animated: true)
    }
    
//    func pendingCloseAlert(sender: UIViewController, title: String, message: String){
//        materialAlertController = MDCAlertController(title: title, message: message)
//        sender.present(materialAlertController!, animated: true, completion: nil)
//    }
    
}

