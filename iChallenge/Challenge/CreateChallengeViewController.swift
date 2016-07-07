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
        changeImageView()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func changeImageView()
    {
        userImage.layer.cornerRadius = 8.0
        userImage.clipsToBounds = true
    }

    @IBAction func createChallengeButtonPressed(sender: AnyObject)
    {
//        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!, callback: { (image: UIImage?) in
//            if let image = image {
//                let imageData = UIImageJPEGRepresentation(image, 0.8)!
//                let imageFile = PFFile(name: "image.jpg", data: imageData)!
//                
//                let post = PFObject(className: "Post")
//                post["imageFile"] = imageFile
//                post.saveInBackground()
//            }
//        })
        
        let titleString = challengeTitle.text
        let descriptionString = challengeDescription.text
        let durationString = challengeDuration.text
        
        let object = PFObject(className: "Challenge")
        object["description"] = descriptionString
        object["title"] = titleString
        object["duration"] = durationString
        object.saveInBackground()
    }
}
