//
//  ChallengeViewController.swift
//  iChallenge
//
//  Created by Jake on 7/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit
import QuartzCore

class ChallengeViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    func changeImageView()
    {
        userImage.layer.cornerRadius = 3;
        userImage.clipsToBounds = true
    }
}
