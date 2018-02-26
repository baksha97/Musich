//
//  HomeViewController.swift
//  Musich
//
//  Created by Loaner on 2/18/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialAppBar
class HomeCollectionViewController: MDCCollectionViewController {

    //MARK: UI Elements
  //  @IBOutlet weak var collectionView: UICollectionView!
    let appBar = MDCAppBar()
    
    //feed items
    var feedItems: [FeedItem] = [FeedItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDateFormatter()
        configureAppBar()
        addFeedItems()
        
        // Set as list layout.
        self.styler.cellLayoutType = .list

        //observe for changes:{
        FIRFirebaseService.shared.observeCurrentUser(completion:{ (bool, err) in
            if bool {
                self.addFeedItems()
            }else{
                print(err.debugDescription)
            }
        })
        
    }
    
    private func addFeedItems(){
                //        old way
        //            FIRFirebaseService.shared.readDatedObjects(from: .publicFeedItems, order: true, returning: FeedItem.self, completion: {(items) in
        //                self.feedItems = items
        //                print(items.count)
        //                print()
        //                self.collectionView.reloadData()
        //            })
        
        //       // TODO: UPDATE SERVICE TO WORK EFFCIENTLY...
        
        HomeFeedService.shared.readFeedItems(completion: { (completed) in
            if completed{
                self.feedItems = HomeFeedService.shared.feedItems
                self.feedItems = self.feedItems.sorted(by: {
                        $0.date.compare($1.date) == .orderedDescending
                    })
                self.collectionView?.reloadData()
            }
            else{
                print("an error has occured gathering your home feed")
            }
        })
    }


    func configureAppBar(){
        addChildViewController(appBar.headerViewController)
        appBar.headerViewController.headerView.backgroundColor = UIColor(red: 1.0, green: 0.76, blue: 0.03, alpha: 1.0)
        
        appBar.headerViewController.headerView.trackingScrollView = self.collectionView
        appBar.addSubviewsToParent()
        
        title = "Music Feed"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Follow", style: .plain, target: self, action: #selector(self.refDidTap))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(self.signOut))
        
        appBar.navigationBar.tintColor = UIColor.black
    }
    
    @objc func signOut(){
        UserRegistrationService.shared.signOut()
    }

    @objc func refDidTap(){
        //self.feedItems = HomeFeedService.shared.feedItems
        //TODO: add ability to follow users via display name
        //TODO: add ability to manage a follwers array
        AlertService.shared.requestNativeAlertInput(
            sender: self, title: "Follow new user", message: "Enter their UID...",
            completion: { (uid) in
                ///TODO: complete
                if let uid = uid{
                    ProfileServices.shared.followUser(with: uid)
                }
            })
    }

    @objc func backDidTap(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellHeightAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(HomeFeedService.shared.feedItemHeightConstant)
        //gotten from storyboard interface
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath)

        if let cell = cell as? FeedCollectionViewCell {
            //data
            cell.userLabel.text = feedItems[indexPath.row].userName 
            cell.songLabel.text = feedItems[indexPath.row].song
            cell.artistLabel.text = feedItems[indexPath.row].artist
            cell.albumLabel.text = feedItems[indexPath.row].album
            FIRFirebaseService.shared.setImageView(view: cell.imageView, with: feedItems[indexPath.row].userID!)
            cell.dateLabel.text = formatter.string(from: feedItems[indexPath.row].date)

        }

        return cell
    }
    
    // MARK: UIScrollViewDelegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == appBar.headerViewController.headerView.trackingScrollView {
            appBar.headerViewController.headerView.trackingScrollDidScroll()
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == appBar.headerViewController.headerView.trackingScrollView {
            appBar.headerViewController.headerView.trackingScrollDidEndDecelerating()
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == appBar.headerViewController.headerView.trackingScrollView {
            let headerView = appBar.headerViewController.headerView
            headerView.trackingScrollDidEndDraggingWillDecelerate(decelerate)
        }
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == appBar.headerViewController.headerView.trackingScrollView {
            let headerView = appBar.headerViewController.headerView
            headerView.trackingScrollWillEndDragging(withVelocity: velocity, targetContentOffset: targetContentOffset)
        }
    }
    
    let formatter = DateFormatter()
    func configureDateFormatter(){
        self.formatter.dateStyle = .medium
        self.formatter.timeStyle = .medium
       // self.formatter.locale = Locale(identifier)
    }
}


