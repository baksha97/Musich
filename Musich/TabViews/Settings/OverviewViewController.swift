//
//  SettingsViewController.swift
//  MusichDemo
//
//  Created by Loaner on 2/21/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit
import MaterialComponents
import MaterialComponents.MaterialNavigationBar

class OverviewViewController: UIViewController, MDCTabBarDelegate {

    @IBOutlet weak var imageView: RoundedImageView!
    @IBOutlet weak var tabBar: MDCTabBar!
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var profileView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configureViews()
        configureImage()
    }
    
    func configureViews(){
        self.settingsView.isHidden = true
        
        
    }
    func configureImage(){
        FIRFirebaseService.shared.setImageView(view: self.imageView, with: (ProfileServices.shared.currentFirebaseUser!.profilePictureURL)) //not working
        setImage()
    }
    
    func configureTabBar(){
        tabBar.backgroundColor = UIColor.black//UIColor(red: 1.0, green: 0.81, blue: 0.0, alpha: 1.0)
        tabBar.items = [
            UITabBarItem(title: "Profile", image: UIImage(named: "nil"), tag: 0),
            UITabBarItem(title: "Settings", image: UIImage(named: "nil"), tag: 0),
        ]
        tabBar.itemAppearance = .titles
        tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.alignment = .justified
        tabBar.sizeToFit()
        tabBar.selectedItem = tabBar.items[0]
        tabBar.delegate = self
    }
    
    func setImage(){
        FIRFirebaseService.shared.setupProfileImageView(view: imageView)
    }
    
    func tabBar(_ tabBar: MDCTabBar, didSelect item: UITabBarItem) {
        if item.title == "Profile" {
            settingsView.isHidden = true
            profileView.isHidden = false
        }
        if item.title == "Settings" {
            settingsView.isHidden = false
            profileView.isHidden = true
        }
    }


}
