//
//  PlayerPickerViewController.swift
//  Musich
//
//  Created by Loaner on 2/19/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation
import Firebase

class PlayerPickerViewController: UIViewController {
    //MARK: OUTLETS
    
    @IBOutlet weak var songField: UITextView!
    
    //MARK: Player
    let player = MPMusicPlayerController.systemMusicPlayer
    
    //MARK: User
    var user: User?
    var fUser = Auth.auth().currentUser
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSongLabel()
        handleUser()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func handleUser(){
        self.user = User(name: (fUser?.displayName)!, number: fUser?.phoneNumber ?? "", id: (fUser?.uid)!, profilePic: UIImage(named: "name")!)
    }
    
    
    func updateSongLabel(){
        if let mediaItem = self.player.nowPlayingItem {
            let title: String = mediaItem.value(forProperty: MPMediaItemPropertyTitle) as! String
            let albumTitle: String = mediaItem.value(forProperty: MPMediaItemPropertyAlbumTitle) as? String ?? "No album available"
            let artist: String = mediaItem.value(forProperty: MPMediaItemPropertyArtist) as? String ?? "No artist available"
            
            print("\(title)")//" on \(albumTitle) by \(artist)")
            
            self.songField.text = title;
            self.songField.text.append("\n \(albumTitle)")
            self.songField.text.append("\n \(artist)")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ///TODO: UPDATE WITH SEGUE IDENTIFIERS
        let chatVc = segue.destination as! ChatVC
        chatVc.currentUser = self.user
        chatVc.channelID = "newChannel_1"
        
    }
 

}
