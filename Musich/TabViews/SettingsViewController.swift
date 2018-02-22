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

class SettingsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var tabBar: MDCTabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = UIColor(red: 1.0, green: 0.81, blue: 0.0, alpha: 1.0)
        //imageView.clipsToBounds = false
       // imageView.contentMode = .scaleAspectFill
        //imageView.contentMode = .scaleAspectFit
        print((ProfileServices.shared.currentFirebaseUser!.profilePictureURL))
        FIRFirebaseService.shared.setImageView(view: self.imageView, with: (ProfileServices.shared.currentFirebaseUser!.profilePictureURL)) //not working
        
        
        //let tabBar = MDCTabBar(frame: view.bounds)
        tabBar.items = [
            UITabBarItem(title: "Profile", image: UIImage(named: "phone"), tag: 0),
            UITabBarItem(title: "Settings", image: UIImage(named: "heart"), tag: 0),
        ]
        tabBar.itemAppearance = .titles
        tabBar.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.alignment = .justified
        tabBar.sizeToFit()
       // view.addSubview(tabBar)
        setImage()
    }

    func setImage(){
        FIRFirebaseService.shared.setImageView(view: self.imageView, with: (ProfileServices.shared.currentFirebaseUser?.profilePictureURL)!)
    }

}
