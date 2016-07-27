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
    var friendArray = [User]()
    var refHandle: FIRDatabaseHandle!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var challengeDescription: UITextView!
    @IBOutlet weak var challengeTitle: UITextField!
    @IBOutlet weak var createChallengeCollectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        changeImageView()
        super.viewDidLoad()

        self.retrieveFriends()
    }
    
    func changeImageView()
    {
        userImage.layer.cornerRadius = 8.0
        userImage.clipsToBounds = true
    }
    
    func retrieveFriends()
    {
        //Pass closure as a parameter to load data being fetched asynchronously in real time
        FirebaseHelper.retrieveFriendID({ (user: User) -> Void in
            
            //Appends the user retrieved from the Database on userArray
            self.friendArray.append(user)
            
            self.createChallengeCollectionView.reloadData()
        })
    }

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = createChallengeCollectionView.dequeueReusableCellWithReuseIdentifier("CreateChallengeCell", forIndexPath: indexPath) as! CreateChallengeViewCell
        
        let friend = friendArray[indexPath.row]
        let profileImageURL = NSURL(string: friend.profileImage)
        
        //Sets the information relevant to the cell on CollectionView
        cell.profileImageView!.af_setImageWithURL(profileImageURL!)
        cell.nameLabel?.text = friend.name
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return friendArray.count
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
            let challengerID = user.uid
            let title: String = challengeTitle.text!
            let description: String = challengeDescription.text!            
            let challenge = Challenge(name: name, challengerID: challengerID, title: title, description: description)
            
            challenge.uploadChallenge() //Uploads challenge to Database
        }
        else
        {
            print("Challenge not created")
        }
    }
}
