//
//  HomeViewController.swift
//  Musich
//
//  Created by Loaner on 2/18/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialAppBar
class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: UI Elements
    let appBar = MDCAppBar()
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
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
    
    
    
    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeFeedCell", for: indexPath)

        if let cell = cell as? HomeFeedCollectionViewCell {

            cell.userLabel.text = "User_temp"
            cell.listeningToLabel.text = "User_listened_to_this_song"
            cell.imageView.image = UIImage(named: "settingsIcon_25")

        }

        return cell
    }
}






//
//import UIKit
//import MaterialComponents.MaterialAppBar
//import MaterialComponents.MaterialButtons
//import MaterialComponents.MaterialCollections
//
//class HomeViewController: MDCCollectionViewController {
//    let appBar = MDCAppBar()
//    let fab = MDCFloatingButton()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        styler.cellStyle = .card
//
//        addChildViewController(appBar.headerViewController)
//        appBar.headerViewController.headerView.backgroundColor = UIColor(red: 1.0, green: 0.76, blue: 0.03, alpha: 1.0)
//
//        appBar.headerViewController.headerView.trackingScrollView = self.collectionView
//        appBar.addSubviewsToParent()
//
//        title = "Material Components"
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.barButtonDidTap))
//
//        appBar.navigationBar.tintColor = UIColor.black
//
//        view.addSubview(fab)
//        fab.translatesAutoresizingMaskIntoConstraints = false
//        fab.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
//        fab.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16.0).isActive = true
//
//        fab.setTitle("+", for: .normal)
//        fab.setTitle("-", for: .selected)
//        fab.addTarget(self, action: #selector(self.fabDidTap), for: .touchUpInside)
//    }
//
//    @objc func barButtonDidTap(sender: UIBarButtonItem) {
//        editor.isEditing = !editor.isEditing
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: editor.isEditing ? "Cancel" : "Edit", style: .plain, target: self, action: #selector(self.barButtonDidTap))
//    }
//
//    @objc func fabDidTap(sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    // MARK: UICollectionViewDataSource
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 5
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
//    }
//
//    //    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//    //
//    //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//    //
//    //        if let textCell = cell as? MDCCollectionViewTextCell {
//    //
//    //            // Add some mock text to the cell.
//    //
//    //            textCell.textLabel?.text = String(describing: indexPath)
//    //
//    //        }
//    //
//    //        return cell
//    //
//    //    }
//    override func collectionView(_ collectionView: UICollectionView, shouldHideHeaderSeparatorForSection section: Int) -> Bool {
//        return false;
//    }
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeFeedCell", for: indexPath)
//
//        if let cell = cell as? HomeFeedCollectionViewCell {
//
//            cell.userLabel.text = "test"
//            cell.listeningToLabel.text = "test listen"
//
//        }
//
//        return cell
//    }
//
//    // MARK: UIScrollViewDelegate
//
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == appBar.headerViewController.headerView.trackingScrollView {
//            appBar.headerViewController.headerView.trackingScrollDidScroll()
//        }
//    }
//
//    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if scrollView == appBar.headerViewController.headerView.trackingScrollView {
//            appBar.headerViewController.headerView.trackingScrollDidEndDecelerating()
//        }
//    }
//
//    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if scrollView == appBar.headerViewController.headerView.trackingScrollView {
//            let headerView = appBar.headerViewController.headerView
//            headerView.trackingScrollDidEndDraggingWillDecelerate(decelerate)
//        }
//    }
//
//    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        if scrollView == appBar.headerViewController.headerView.trackingScrollView {
//            let headerView = appBar.headerViewController.headerView
//            headerView.trackingScrollWillEndDragging(withVelocity: velocity, targetContentOffset: targetContentOffset)
//        }
//    }
//}
//
//

