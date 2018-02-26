//
//  Musich
//
//  Created by Loaner on 2/25/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialCollections

class ProfileCollectionView: MDCCollectionViewController {
    //MARK: UI Elements
    
    //feed items
    var feedItems: [FeedItem] = [FeedItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDateFormatter()
        addFeedItems()
        
        // Set as list layout.
        self.styler.cellLayoutType = .list
    }
    
    private func addFeedItems(){
        //Observing...
        FIRFirebaseService.shared.observeCurrentUser(completion:{ (completed, error) in
            if completed{
                if let feed = ProfileServices.shared.currentFirebaseUser?.feedItems {
                    self.feedItems = feed
                    self.feedItems = self.feedItems.sorted(by: {
                        $0.date.compare($1.date) == .orderedDescending
                    })
                    self.collectionView?.reloadData()
                }
            }else{
                print(error.debugDescription)
            }
        })
    }
    
    
    
    @objc func refDidTap(){
        self.feedItems = HomeFeedService.shared.feedItems
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
        return 110 //got from storyboard interface
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath)
        
        if let cell = cell as? FeedCollectionViewCell {
            //data
            cell.userLabel.text = feedItems[indexPath.row].userName //"User_temp"
            cell.songLabel.text = feedItems[indexPath.row].song
            cell.artistLabel.text = feedItems[indexPath.row].artist
            cell.albumLabel.text = feedItems[indexPath.row].album
            FIRFirebaseService.shared.setImageView(view: cell.imageView, with: feedItems[indexPath.row].userID!)
            cell.dateLabel.text = formatter.string(from: feedItems[indexPath.row].date)
        }

        return cell
    }
    
    let formatter = DateFormatter()
    func configureDateFormatter(){
        self.formatter.dateStyle = .medium
        self.formatter.timeStyle = .medium
    }

}
