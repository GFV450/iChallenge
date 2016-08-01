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
    var viewInfo: (profileImage: UIImage, title: String, description: String)?
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var challengeTitle: UILabel!
    @IBOutlet weak var challengeDescription: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setChallengeInfo()
    }
    
    func setChallengeInfo()
    {
        userImageView.image = viewInfo?.profileImage
        challengeTitle.text = viewInfo?.title
        challengeDescription.text = viewInfo?.description
    }
}
