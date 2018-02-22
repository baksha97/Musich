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
    
    //feed items
    var feedItems: [FeedItem] = [FeedItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDateFormatter()
        collectionView.delegate = self
        //configureAppBar()
        addFeedItems()
    }
    
    private func addFeedItems(){
        FIRFirebaseService.shared.read(from: .publicFeedItems, returning: FeedItem.self, completion: {(items) in
            self.feedItems = items
            print(items.count)
            print()
            self.collectionView.reloadData()
        })
    }


//    func configureAppBar(){
//        addChildViewController(appBar.headerViewController)
//        appBar.headerViewController.headerView.backgroundColor = UIColor(red: 1.0, green: 0.81, blue: 0.0, alpha: 1.0)
//        appBar.addSubviewsToParent()
//        title = "Musich Home"
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Me", style: .plain, target: self, action: #selector(self.meDidTap))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(self.backDidTap))
//
//        appBar.navigationBar.tintColor = UIColor.black
//
//    }

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
            cell.listeningToLabel.text = "\(feedItems[indexPath.row].song), by: \(feedItems[indexPath.row].description)" //"User_listened_to_this_song"
            FIRFirebaseService.shared.setImageView(view: cell.imageView, with: feedItems[indexPath.row].userID!)
            
            cell.dateLabel.text = formatter.string(from: feedItems[indexPath.row].date)

        }

        return cell
    }
    
    let formatter = DateFormatter()
    func configureDateFormatter(){
        self.formatter.dateStyle = .medium
        self.formatter.timeStyle = .none
       // self.formatter.locale = Locale(identifier)
    }
}


