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
    
    //MARK: Outlets
    @IBOutlet weak var emailField: MDCTextField!
    @IBOutlet weak var passwordField: MDCTextField!
    @IBOutlet weak var confirmPasswordField: MDCTextField!
    
    //MARK: UI Elements
    let appBar = MDCAppBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAppBar()
    }

    func configureAppBar(){
        addChildViewController(appBar.headerViewController)
        appBar.headerViewController.headerView.backgroundColor = UIColor(red: 1.0, green: 0.81, blue: 0.0, alpha: 1.0)
        appBar.addSubviewsToParent()
        title = "Create Account"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.backDidTap))
        appBar.navigationBar.tintColor = UIColor.black
    }
    @objc func backDidTap(){
        self.dismiss(animated: true, completion: nil)
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
