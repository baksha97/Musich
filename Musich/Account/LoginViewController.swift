//
//  ViewController.swift
//  Musich
//
//  Created by Loaner on 2/9/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialNavigationBar
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialCollections
import MaterialComponents.MaterialTextFields
import MaterialComponents.MDCTextField
import MaterialComponents.MDCTextInputControllerLegacyDefault
import MaterialComponents.MDCTextInputController

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var emailField: MDCTextField!
    @IBOutlet weak var passwordField: MDCTextField!
    
    
    var emailController: MDCTextInputControllerLegacyDefault?
    var passwordController: MDCTextInputControllerLegacyDefault?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFields()
    }
    
    func configureFields(){
        emailField.delegate = self
        passwordField.delegate = self
        emailController = MDCTextInputControllerLegacyDefault(textInput: emailField)
        passwordController = MDCTextInputControllerLegacyDefault(textInput: passwordField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
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


