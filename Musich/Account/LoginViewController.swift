//
//  ViewController.swift
//  Musich
//
//  Created by Loaner on 2/9/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit
import MaterialComponents.MDCTextField
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialNavigationBar
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialCollections
import MaterialComponents.MDCTextInputControllerLegacyDefault
import MaterialComponents.MDCTextInputController

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var emailField: MDCTextField!
    @IBOutlet weak var passwordField: MDCTextField!
    
    
    
//    let appBar = MDCAppBar()
//    let fab = MDCFloatingButton()
    
    var emailController: MDCTextInputControllerLegacyDefault?
    var passwordController: MDCTextInputControllerLegacyDefault?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailController = MDCTextInputControllerLegacyDefault(textInput: emailField)
        passwordController = MDCTextInputControllerLegacyDefault(textInput: passwordField)
        
        //wat()
    }
    
//    func wat(){
//
//        addChildViewController(appBar.headerViewController)
//        appBar.headerViewController.headerView.backgroundColor = UIColor(red: 1.0, green: 0.76, blue: 0.03, alpha: 1.0)
//
//      //  appBar.headerViewController.headerView.trackingScrollView = self.collectionView
//        appBar.addSubviewsToParent()
//
//        title = "MUSICH"
//
//    //    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.barButtonDidTap))
//
//        appBar.navigationBar.tintColor = UIColor.black
//
//        view.addSubview(fab)
//        fab.translatesAutoresizingMaskIntoConstraints = false
//        fab.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
//        fab.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16.0).isActive = true
//
//        fab.setTitle("login", for: .normal)
//        fab.setTitle("", for: .selected)
//        fab.addTarget(self, action: #selector(self.fabDidTap), for: .touchUpInside)
//    }
//
//    @objc func fabDidTap(sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        self.performSegue(withIdentifier: "loginToView", sender: self)
//    }
//
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}


