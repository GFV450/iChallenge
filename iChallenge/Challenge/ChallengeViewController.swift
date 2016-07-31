//
//  ChallengeViewController.swift
//  iChallenge
//
//  Created by Jake on 7/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController
{
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var challengeTitle: UILabel!
    @IBOutlet weak var challengeDescription: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    static func fillChallengeScreen(callback:() -> (title: String, description: String, profileImage: UIImage) )
    {
        
    }
}
