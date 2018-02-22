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
        super.viewWillAppear(animated)
        updateSongLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    func updateSongLabel(){
        self.songField.text = MusicServices.shared.currentTitle;
        self.songField.text.append("\n \(MusicServices.shared.artist!)")
        self.songField.text.append("\n \(MusicServices.shared.albumTitle!)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ///TODO: UPDATE WITH SEGUE IDENTIFIERS
        let chatVc = segue.destination as! ChatVC
        chatVc.channelID = songField.text.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }
 

}
