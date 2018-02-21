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
    //MARK: Development
    var fUser = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFields()
        loginFunction()
//        let f1 = FeedItem(userID: (fUser?.uid)!, userName: "Travis", song: "Riding Shotgun", description: "Kygo", date: Date())
//        let f2 = FeedItem(userID: (fUser?.uid)!, userName: "Travis", song: "Love Lies", description: "Khalid", date: Date())
////        let f3 = FeedItem(userID: (fUser?.uid)!, userName: "Travis", song: "Don't Let Me Down", description: "The Chainsmokers", date: Date())
//        f1.pushFeedItem()
//        f2.pushFeedItem()
////        f3.pushFeedItem()
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //DEVELOPMENT LOGIN
    func loginFunction(){
        Auth.auth().signIn(withEmail: "travis@dev.com",
                               password: "123456", completion: { user, error in
                                
                                if error != nil { //unsucessful
                                    let alert = UIAlertController(title: "Login Error...",
                                                                  message: "Please register for an account!",
                                                                  preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "Okay",
                                                                 style: .default)
                                    alert.addAction(okAction)
                                    self.present(alert, animated: true, completion: nil)
                                }
                                else{
                                    print("logged in successfully!!!")
//                                    self.dismiss(animated: true, completion: nil)
//                                    self.performSegue(withIdentifier: "loginToTab", sender: nil)
                                    self.fUser = Auth.auth().currentUser
                                    //temp display name update
                                    let changeRequest = self.fUser?.createProfileChangeRequest()
                                    changeRequest?.displayName = "user_DisplayName"
                                    changeRequest?.commitChanges { error in
                                        if let _ = error {
                                            // An error happened.
                                        } else {
                                            print(self.fUser?.displayName! ?? "DISPLAY NAME IS NIL!")
                                        }
                                    }
                                }
        })
        
    }
    
    
}


