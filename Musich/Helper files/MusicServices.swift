//
//  MusicServices.swift
//  Musich
//
//  Created by Loaner on 2/22/18.
//  Copyright © 2018 baksha97. All rights reserved.
//Spotify references... https://stackoverflow.com/questions/43882508/spotify-sdk-in-swift-3-0-how-to-know-when-a-song-ends
//

import Foundation
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
    
    var currentTitle: String?
    var artist: String?
    var albumTitle: String?
    
    func start(){}
    
    @objc func setNowPlayingInformation(){ //-> (title: String, artist: String, album: String)?{
        if let mediaItem = self.player.nowPlayingItem {
            currentTitle = (mediaItem.value(forProperty: MPMediaItemPropertyTitle) as! String)
            artist = mediaItem.value(forProperty: MPMediaItemPropertyArtist) as? String ?? ""
            albumTitle = mediaItem.value(forProperty: MPMediaItemPropertyAlbumTitle) as? String ?? ""
           // return (title, albumTitle, artist)
        }
        print("Song Information Empty - MUSICSERVICES")
    }
    
    
    func observeChange(completion: @escaping(Bool) -> Void){
        completion(true)
    }
    
    deinit {
        player.endGeneratingPlaybackNotifications()
        NotificationCenter.default.removeObserver(self)
    }
}
