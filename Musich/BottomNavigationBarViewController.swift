//
//  SettingsViewController.swift
//  Musich
//
//  Created by Loaner on 2/18/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit
import MaterialComponents

class BottomNavigationBarViewController: UIViewController, MDCBottomNavigationBarDelegate {

    @IBOutlet weak var bottomNavigationBar: MDCBottomNavigationBar!
    
    
    
    //MARK: UI Elements
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBottomBar()
    }
    
    func configureBottomBar(){
        bottomNavigationBar.delegate = self
        bottomNavigationBar.items = [
            UITabBarItem(title: "Home", image: UIImage(named: "homeIcon_25"), tag: 0),
            UITabBarItem(title: "Musich", image: UIImage(named: "messageIcon_30"), tag: 0),
            UITabBarItem(title: "Settings", image: UIImage(named: "settingsIcon_25"), tag:0)
        ]
        bottomNavigationBar.items[0].badgeColor = UIColor.cyan
        //bottomNavigationBar.items[0]//UIColor.white
        bottomNavigationBar.backgroundColor = UIColor(red: 1.0, green: 0.81, blue: 0.0, alpha: 1.0)
    }
    
    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, shouldSelect item: UITabBarItem) -> Bool {
        return true
    }

    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
        print(item.title!)
    }

}
