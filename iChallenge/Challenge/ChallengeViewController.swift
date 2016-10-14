//
//  ChallengeViewController.swift
//  iChallenge
//
//  Created by Jake on 7/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit
import SDWebImage

class ChallengeViewController: UIViewController
{
    var challenge: Challenge?
    
    @IBOutlet weak var challengerProfileImage: UIImageView!
    @IBOutlet weak var challengeTitle: UILabel!
    @IBOutlet weak var challengeDescription: UILabel!
    @IBOutlet weak var challengeCompleteButton: UIButton!
    @IBOutlet weak var reportButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setChallengeInfo()
    }
    
    func setChallengeInfo()
    {
        let profileImageURL = URL(string: (challenge?.challengerProfileImage)!)
        
        challengerProfileImage.sd_setImage(with: profileImageURL)
        challengerProfileImage.layer.cornerRadius = challengerProfileImage.frame.size.width/2
        
        challengeTitle.text = challenge?.challengeTitle
        challengeDescription.text = challenge?.challengeDescription
    }
    
    @IBAction func completeChallengeButtonPressed(_ sender: AnyObject)
    {
        challenge?.challengeCompleted()
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reportButtonPressed(_ sender: AnyObject)
    {
        challenge?.challengeReported()
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissButtonPressed(_ sender: AnyObject)
    {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
