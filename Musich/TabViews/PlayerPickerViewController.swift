//
//  PlayerPickerViewController.swift
//  Musich
//
//  Created by Loaner on 2/19/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons

class PlayerPickerViewController: UIViewController {
    //MARK: OUTLETS
    
    @IBOutlet weak var songField: UITextView!
    
    @IBOutlet weak var appleMusicButton: MDCFlatButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MusicServices.shared.setAppleMusicButton(with: appleMusicButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        ///TODO: UPDATE WITH SEGUE IDENTIFIERS
        let chatVc = segue.destination as! ChatVC
        chatVc.channelID = MusicServices.shared.channelID
    }
 

}
