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
    @IBOutlet weak var collectionView: UICollectionView!
    let appBar = MDCAppBar()
    
    //feed items
    var feedItems: [FeedItem] = [FeedItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDateFormatter()
        collectionView.delegate = self
        configureAppBar()
        addFeedItems()
    }
    
    private func addFeedItems(){
        FIRFirebaseService.shared.readDatedObjects(from: .publicFeedItems, order: true, returning: FeedItem.self, completion: {(items) in
            self.feedItems = items
            print(items.count)
            print()
            self.collectionView.reloadData()
        })
    }


    func configureAppBar(){
        addChildViewController(appBar.headerViewController)
        appBar.headerViewController.headerView.backgroundColor = UIColor(red: 1.0, green: 0.76, blue: 0.03, alpha: 1.0)
        
        appBar.headerViewController.headerView.trackingScrollView = self.collectionView
        appBar.addSubviewsToParent()
        
        title = "Music Feed"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(self.meDidTap))
        
        appBar.navigationBar.tintColor = UIColor.black
    }

    @objc func meDidTap(){

    }

    @objc func backDidTap(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeFeedCell", for: indexPath)

        if let cell = cell as? HomeFeedCollectionViewCell {

            cell.userLabel.text = feedItems[indexPath.row].userName //"User_temp"
            cell.songLabel.text = feedItems[indexPath.row].song
            cell.artistLabel.text = feedItems[indexPath.row].artist
            cell.albumLabel.text = feedItems[indexPath.row].album
            FIRFirebaseService.shared.setImageView(view: cell.imageView, with: feedItems[indexPath.row].userID!)
            cell.dateLabel.text = formatter.string(from: feedItems[indexPath.row].date)

        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    let formatter = DateFormatter()
    func configureDateFormatter(){
        self.formatter.dateStyle = .medium
        self.formatter.timeStyle = .medium
       // self.formatter.locale = Locale(identifier)
    }
}


