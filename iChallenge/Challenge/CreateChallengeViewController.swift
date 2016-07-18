//
//  CreateChallengeViewController.swift
//  iChallenge
//
//  Created by Jake on 7/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit
import Firebase

class CreateChallengeViewController: UIViewController
{
    var dataRef: FIRDatabaseReference!
    var infoArray = ["mary", "elisa"]
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var challengeDuration: UITextField!
    @IBOutlet weak var challengeDescription: UITextView!
    @IBOutlet weak var challengeTitle: UITextField!
    @IBOutlet weak var createChallengeCollectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        dataRef = FIRDatabase.database().reference().child("Users")
        changeImageView()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func changeImageView()
    {
        userImage.layer.cornerRadius = 8.0
        userImage.clipsToBounds = true
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = createChallengeCollectionView.dequeueReusableCellWithReuseIdentifier("CreateChallengeCell", forIndexPath: indexPath) as! CreateChallengeViewCell
        
        let info = infoArray[indexPath.row]
        cell.nameLabel.text = info
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return infoArray.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    @IBAction func createChallengeButtonPressed(sender: AnyObject)
    {
        if let user = FIRAuth.auth()?.currentUser
        {
            //Unwrap optionals before pushing to Firebase Database
            let name = user.displayName!
            let userID = user.uid
            let title: String = challengeTitle.text!
            let description: String = challengeDescription.text!
            let duration: String = challengeDuration.text!
            
            let challenge = Challenge(name: name, userID: userID, title: title, description: description, duration: duration)
            challenge.uploadChallenge()
        }
        else
        {
            print("Challenge not created")
        }
    }
}
