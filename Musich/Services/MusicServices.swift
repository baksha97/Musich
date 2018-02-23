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
import MaterialComponents.MaterialButtons
import MediaPlayer

class MusicServices{
    
    //TODO MAKE NSMUSIC REQUEST BEFORE LOGIN OR ELSE APP BUTTON WONT WORK INITALLY ON FIRST RUN
    //TODO ADD -IF PAUSED, NO CURRENT SONG! Song should be playing to be able to enter a chat.
    private init(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2){ //added delay to avoid double addition to firebase
            NotificationCenter.default.addObserver(self, selector: #selector(self.setNowPlayingInformation), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
            self.player.beginGeneratingPlaybackNotifications()
        }
    }
    
    static let shared = MusicServices()
    private lazy var player = MPMusicPlayerController.systemMusicPlayer
    
    
    private var currentTitle: String?
    private var artist: String?
    private var albumTitle: String?
    
    private var appleMusicTextView: UITextView?
    private var chatObserver: UIViewController?
    
    var channelID: String?
    
    func start(){}
    
    @objc private func setNowPlayingInformation(){ //-> (title: String, artist: String, album: String)?{
        if let mediaItem = self.player.nowPlayingItem {
            currentTitle = mediaItem.value(forProperty: MPMediaItemPropertyTitle) as? String
            artist = mediaItem.value(forProperty: MPMediaItemPropertyArtist) as? String ?? ""
            albumTitle = mediaItem.value(forProperty: MPMediaItemPropertyAlbumTitle) as? String ?? ""
            setChannelID()
            publishItem()
        }else{
           print("Song Information Empty - setNowPlaying.MusicServices")
        }
        reloadObservers()
    }
    
    private func setChannelID(){
        var id = "\(currentTitle!)\(artist!)\(albumTitle!)"
        id = id.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ".", with: "")
        channelID = id
    }
    
    //MARK: Feed Item configurations
    private func publishItem(){
        let user = ProfileServices.shared.currentFirebaseUser!
        let feedItem = FeedItem(userID: user.id!, userName: user.name,
                                song: self.currentTitle!, artist: "\(self.artist ?? "*Artist Unavailable*")",
                                album: "\(self.albumTitle ?? "*Album Unavailable*")", date: Date())
        feedItem.publishPublicly()
        ProfileServices.shared.addFeedItem(feedItem: feedItem)
    }

    //MARK: Observer Configurations.
    func setChatObserver(with chatObserver: UIViewController){
        self.chatObserver = chatObserver
    }
    
    func setAppleMusicTextView(with view: UITextView){ // want to specifically use this type of button
        self.appleMusicTextView = view
    }
    private func reloadObservers(){
        //
        let text = "Apple Music: \(currentTitle ?? "") by \(artist ?? "") in \(albumTitle ?? "")"
        self.appleMusicTextView?.text = text
        //self.appleMusicButton?.setTitle(buttonText, for: .normal)//currentTitle = channelID
        self.chatObserver?.dismiss(animated: true, completion: nil)
        print("RELOADED OBSERVERS")
    }
    
    deinit {
        player.endGeneratingPlaybackNotifications()
        NotificationCenter.default.removeObserver(self)
    }
}
