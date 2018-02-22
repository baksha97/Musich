//
//  MusicServices.swift
//  Musich
//
//  Created by Loaner on 2/22/18.
//  Copyright © 2018 baksha97. All rights reserved.
//Spotify references... https://stackoverflow.com/questions/43882508/spotify-sdk-in-swift-3-0-how-to-know-when-a-song-ends
//

import Foundation
import UIKit
import AVKit
import AVFoundation
import MediaPlayer

class MusicServices{
    
    private init(){
        NotificationCenter.default.addObserver(self, selector: #selector(setNowPlayingInformation), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        player.beginGeneratingPlaybackNotifications()
    }
    
    static let shared = MusicServices()
    private lazy var player = MPMusicPlayerController.systemMusicPlayer
    
    
    private var currentTitle: String?
    private var artist: String?
    private var albumTitle: String?
    
    private var observer: UIViewController?
    private var chatObserver: UIViewController?
    
    func start(){}
    
    @objc private func setNowPlayingInformation(){ //-> (title: String, artist: String, album: String)?{
        if let mediaItem = self.player.nowPlayingItem {
            currentTitle = mediaItem.value(forProperty: MPMediaItemPropertyTitle) as? String
            artist = mediaItem.value(forProperty: MPMediaItemPropertyArtist) as? String ?? ""
            albumTitle = mediaItem.value(forProperty: MPMediaItemPropertyAlbumTitle) as? String ?? ""
           // return (title, albumTitle, artist)
        }else{
           print("Song Information Empty - MUSICSERVICES")
        }
        reloadObservers()
    }
    
    func getSongInformation() -> (title: String, artist: String, album: String)?{
        if(self.player.nowPlayingItem != nil){
            return (title: currentTitle!, artist: artist!, album: albumTitle!)
        }
        else{
            return nil
        }
    }
    
    func setChatObserver(with chatObserver: UIViewController){
        self.chatObserver = chatObserver
    }
    
    func setObserver(with observer: UIViewController){
        self.observer = observer
    }
    private func reloadObservers(){
        self.observer?.viewWillDisappear(true)
        self.observer?.viewDidLoad()
        self.chatObserver?.dismiss(animated: true, completion: nil)
        print("RELOADED OBSERVERS")
    }
    
    deinit {
        player.endGeneratingPlaybackNotifications()
        NotificationCenter.default.removeObserver(self)
    }
}
