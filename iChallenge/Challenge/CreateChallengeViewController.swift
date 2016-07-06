//
//  CreateChallengeViewController.swift
//  iChallenge
//
//  Created by Jake on 7/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit
import Parse

class CreateChallengeViewController: UIViewController
{
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var challengeDuration: UITextField!
    @IBOutlet weak var challengeDescription: UITextView!
    @IBOutlet weak var challengeTitle: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func changeImageView()
    {
        userImage.layer.cornerRadius = 3;
        userImage.clipsToBounds = true
    }

    @IBAction func createChallengeButtonPressed(sender: AnyObject)
    {
        let object = PFObject(className: "Challenge")
    }
}
