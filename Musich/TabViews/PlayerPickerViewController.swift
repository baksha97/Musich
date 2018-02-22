//
//  PlayerPickerViewController.swift
//  Musich
//
//  Created by Loaner on 2/19/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit

class PlayerPickerViewController: UIViewController {
    //MARK: OUTLETS
    
    @IBOutlet weak var songField: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MusicServices.shared.setObserver(with: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSongLabel()
        // Do any additional setup after loading the view.
    }
    
    
    
    func updateSongLabel(){
        if(MusicServices.shared.getSongInformation() != nil){
            if let (title, artist, album) = MusicServices.shared.getSongInformation() {
                self.songField.text = title
                self.songField.text.append("\n \(artist)")
                self.songField.text.append("\n \(album)")
            }else{
                self.songField.text = "Your song info..."
                print("no currently playing songs")
            }
        }
        
//        self.songField.text = MusicServices.shared.currentTitle;
//        self.songField.text.append("\n \(MusicServices.shared.artist!)")
//        self.songField.text.append("\n \(MusicServices.shared.albumTitle!)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ///TODO: UPDATE WITH SEGUE IDENTIFIERS
        let chatVc = segue.destination as! ChatVC
        //TODO Enter only when there is a song item playing
        chatVc.channelID = "test"//songField.text.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }
 

}
