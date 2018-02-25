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
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var emailField: MDCTextField!
    @IBOutlet weak var passwordField: MDCTextField!
    
    @IBAction func unwindToLoginViewController(segue: UIStoryboardSegue){}
    
    var emailController: MDCTextInputControllerLegacyDefault?
    var passwordController: MDCTextInputControllerLegacyDefault?
    
    let navigationBarSegue = "loginToNavigationBarSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFields()
        
        //MARK: Development login
        emailField.text = "travis@dev.com"
        passwordField.text = "123456"
    }
    
    
    //DEVELOPMENT:
    
    
    
    
    @IBAction func loginDidTap(_ sender: Any) {
        //TEMP FOR DEV
        if(emailField.text != nil && passwordField.text != nil){
            UserRegistrationService.shared.loginUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (completed, error) in
                if(completed){
                    //MDCAlertService.shared.okAlert(sender: self, title: "You're signed in", message: "Welcome")
                    self.performSegue(withIdentifier: self.navigationBarSegue, sender: self)
                } else{
                    MDCAlertService.shared.okAlert(sender: self, title: "An error occured, please try again.", message: (error.debugDescription))
                }
            })
        }
        else{
             MDCAlertService.shared.okAlert(sender: self, title: "An error occured, please try again.", message: "Enter an appropriate email and password.")
        }
    }
    
    
    //MARK: Text Field Methods
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
    
