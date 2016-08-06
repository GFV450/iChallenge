//
//  ChallengeViewController.swift
//  iChallenge
//
//  Created by Jake on 7/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit
import AlamofireImage

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
        let profileImageURL = NSURL(string: (challenge?.challengerProfileImage)!)
        
        challengerProfileImage.af_setImageWithURL(profileImageURL!)
        challengerProfileImage.image = challengerProfileImage.image?.af_imageRoundedIntoCircle()
        
        challengeTitle.text = challenge?.challengeTitle
        challengeDescription.text = challenge?.challengeDescription
    }
    
    @IBAction func completeChallengeButtonPressed(sender: AnyObject)
    {
        challenge?.challengeCompleted()
    }
    
    @IBAction func reportButtonPressed(sender: AnyObject)
    {
        challenge?.challengeReported()
    }
    
    @IBAction func dismissButtonPressed(sender: AnyObject)
    {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}