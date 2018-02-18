//
//  CreateAccountViewController.swift
//  Musich
//
//  Created by Loaner on 2/17/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialAppBar
import MaterialComponents.MDCTextField
import MaterialComponents.MDCTextInputControllerLegacyDefault

class CreateAccountViewController: UIViewController, UITextFieldDelegate{
    
    //MARK: Segues
    let createProfileSegue = "createProfileSegue"
    
    //MARK: Outlets
    @IBOutlet weak var emailField: MDCTextField!
    @IBOutlet weak var passwordField: MDCTextField!
    @IBOutlet weak var confirmPasswordField: MDCTextField!
    
    //MARK: UI Elements
    let appBar = MDCAppBar()
    var emailController: MDCTextInputControllerLegacyDefault?
    var passwordController: MDCTextInputControllerLegacyDefault?
    var confirmPasswordController: MDCTextInputControllerLegacyDefault?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAppBar()
        configureFields()
    }

    func configureAppBar(){
        addChildViewController(appBar.headerViewController)
        appBar.headerViewController.headerView.backgroundColor = UIColor(red: 1.0, green: 0.81, blue: 0.0, alpha: 1.0)
        appBar.addSubviewsToParent()
        title = "Create Account"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.backDidTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.nextDidTap))
        
        appBar.navigationBar.tintColor = UIColor.black
        
    }
    
    @objc func nextDidTap(){
        if(passwordField.text == confirmPasswordField.text){
            print("good");
            confirmPasswordController?.setErrorText(nil, errorAccessibilityValue: nil)
            performSegue(withIdentifier: createProfileSegue, sender: self)
        }
        else{
            confirmPasswordField.text = ""
            confirmPasswordController?.setErrorText("Passwords must match", errorAccessibilityValue: nil)
        }
    }
    @objc func backDidTap(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureFields(){
        emailField.delegate = self
        passwordField.delegate = self
        emailController = MDCTextInputControllerLegacyDefault(textInput: emailField)
        passwordController = MDCTextInputControllerLegacyDefault(textInput: passwordField)
        confirmPasswordController = MDCTextInputControllerLegacyDefault(textInput: confirmPasswordField)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
