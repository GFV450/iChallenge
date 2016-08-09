//
//  CompletedChallengeViewController.swift
//  iChallenge
//
//  Created by Gian Vitola on 8/7/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit
import FirebaseAuth

class CompletedChallengeViewController: UIViewController
{
    var challenge: Challenge?
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var challengeTitle: UILabel!
    @IBOutlet weak var challengeDescription: UILabel!
    @IBOutlet weak var challengeLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setChallengeInfo()
    }
    
    func setChallengeInfo()
    {
        let challengerProfileImageURL = NSURL(string: (challenge?.challengerProfileImage)!)
        let foeProfileImageURL = NSURL(string: (challenge?.foeProfileImage)!)
        
        challengeTitle.text = challenge?.challengeTitle
        challengeDescription.text = challenge?.challengeDescription
        
        let user = (FIRAuth.auth()?.currentUser)!
        
        if(user.uid == challenge?.foeID)
        {
            challengeLabel.text = "You were challenged to"
            
            profileImage.af_setImageWithURL(challengerProfileImageURL!)
            profileImage.image = profileImage.image?.af_imageRoundedIntoCircle()
            
        }
        else
        {
            challengeLabel.text = "You challenged your friend to"
            
            profileImage.af_setImageWithURL(foeProfileImageURL!)
            profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        }
    }
    
    @IBAction func dismissButtonPressed(sender: AnyObject)
    {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

}
