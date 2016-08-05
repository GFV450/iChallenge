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
    var selectedFriendID: String?
    
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
        let user = FIRAuth.auth()?.currentUser
        
        let profileImageURL = user!.photoURL
        
        userImage.layer.cornerRadius = 10
        userImage.af_setImageWithURL(profileImageURL!)
    }
    
    func retrieveFriends()
    {
        //Pass closure as a parameter to load data being fetched asynchronously in real time
        FirebaseHelper.queryFriendObject({ (user: User) -> Void in
            
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
        
        if(cell.userID == selectedFriendID)
        {
            cell.contentView.backgroundColor = UIColor.greenColor()
        }
        else
        {
            cell.contentView.backgroundColor = UIColor.whiteColor()
        }
        
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
        let user = (FIRAuth.auth()?.currentUser)!
        
        //Sets all the information in constants to instantiate a Challenge object
        let challengerName = user.displayName!
        let challengerID = user.uid
        let challengerProfileImage = (FIRAuth.auth()?.currentUser?.photoURL?.absoluteString)! //Unwrapping value
        let challengeTitle: String = self.challengeTitle.text!
        let challengeDescription: String = self.challengeDescription.text!
        let foeID: String? = selectedFriendID
        
        //Creates challenge
        let challenge = Challenge(challengerName: challengerName, challengerID: challengerID, challengerProfileImage: challengerProfileImage, foeID: foeID!, challengeTitle: challengeTitle, challengeDescription: challengeDescription)
        
        //Checks that the user has picked a friend to challenge
        if(foeID != nil)
        {
            challenge.uploadChallenge() //Uploads challenge to Database
        }
        else
        {
            print("Challenge not created: Friend not selected")
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CreateChallengeViewCell
        
        selectedFriendID = cell.userID
        cell.contentView.backgroundColor = UIColor.greenColor()
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CreateChallengeViewCell
        
        cell.contentView.backgroundColor = UIColor.whiteColor()
    }
}

