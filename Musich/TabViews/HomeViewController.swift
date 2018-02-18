//
//  HomeViewController.swift
//  Musich
//
//  Created by Loaner on 2/18/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialAppBar
class HomeViewController: UIViewController {

    //MARK: UI Elements
    let appBar = MDCAppBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppBar()
        // Do any additional setup after loading the view.
    }


    func configureAppBar(){
        addChildViewController(appBar.headerViewController)
        appBar.headerViewController.headerView.backgroundColor = UIColor(red: 1.0, green: 0.81, blue: 0.0, alpha: 1.0)
        appBar.addSubviewsToParent()
        title = "Musich Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Me", style: .plain, target: self, action: #selector(self.meDidTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(self.backDidTap))
        
        appBar.navigationBar.tintColor = UIColor.black
        
    }

    @objc func meDidTap(){
        
    }
    
    @objc func backDidTap(){
        self.dismiss(animated: true, completion: nil)
    }

}
