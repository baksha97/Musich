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
    
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var musichView: UIView!
    @IBOutlet weak var settingsView: UIView!
    
    
    //MARK: UI Elements
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBottomBar()
        configureViews()
    }
    
    func configureViews(){
        homeView.isHidden = false
        musichView.isHidden = true
        settingsView.isHidden = true
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
        bottomNavigationBar.selectedItem = bottomNavigationBar.items.first
    }
    
    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, shouldSelect item: UITabBarItem) -> Bool {
        return true
    }

    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
        if(item.title == "Home"){
            homeView.isHidden = false
            musichView.isHidden = true
            settingsView.isHidden = true
        }
        else if(item.title == "Musich"){
            homeView.isHidden = true
            musichView.isHidden = false
            settingsView.isHidden = true
        }
        else if(item.title == "Settings"){
            homeView.isHidden = true
            musichView.isHidden = true
            settingsView.isHidden = false
        }
        else{
            print("Something has gone terribly wrong.... \(String(describing: self.title))")
        }
    }

}
