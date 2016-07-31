//
//  CreateChallengeViewController.swift
//  iChallenge
//
//  Created by Jake on 7/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit
import Firebase

class CreateChallengeViewController: UIViewController, UICollectionViewDelegate
{
    var friendArray = [User]()
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var challengeDescription: UITextView!
    @IBOutlet weak var challengeTitle: UITextField!
    @IBOutlet weak var createChallengeCollectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        setImageView()
        super.viewDidLoad()

        self.retrieveFriends()
        
        createChallengeCollectionView.allowsMultipleSelection = false
        
    }
    
    func setImageView()
    {
        if let user = FIRAuth.auth()?.currentUser
        {
            let profileImageURL = user.photoURL
            
            userImage.af_setImageWithURL(profileImageURL!)
        }
        else
        {
            print("No user logged in")
        }
    }
    
    func retrieveFriends()
    {
        //Pass closure as a parameter to load data being fetched asynchronously in real time
        FirebaseHelper.queryFriendID({ (user: User) -> Void in
            
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
        cell.userID = friend.userID
        
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
            let challengerProfileImage = (FIRAuth.auth()?.currentUser?.photoURL?.absoluteString)! //Unwrapping value
            let title: String = challengeTitle.text!
            let description: String = challengeDescription.text!
            
            let foeID = self.retrieveFoeID()
            
            let challenge = Challenge(name: name, challengerID: challengerID, challengerProfileImage: challengerProfileImage, foeID: foeID, title: title, description: description)
            
            if(foeID != "")
            {
                challenge.uploadChallenge() //Uploads challenge to Database
            }
            else
            {
                print("No friend selected. Challenge not created")
            }
        }
        else
        {
            print("Challenge not created")
        }
    }
    
    func retrieveFoeID() -> String
    {
        for cell in createChallengeCollectionView.visibleCells() as! [CreateChallengeViewCell]
        {
            if(cell.contentView.backgroundColor == UIColor.greenColor())
            {
                let foeID = cell.userID
                return foeID
            }
        }
        
        return ""
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CreateChallengeViewCell
        
        cell.contentView.backgroundColor = UIColor.greenColor()
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CreateChallengeViewCell
        
        cell.contentView.backgroundColor = UIColor.whiteColor()
    }
}

