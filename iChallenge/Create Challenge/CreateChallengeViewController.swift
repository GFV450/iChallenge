//
//  CreateChallengeViewController.swift
//  iChallenge
//
//  Created by Jake on 7/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit
import Firebase
import Material
import SDWebImage

class CreateChallengeViewController: UIViewController, UICollectionViewDelegate
{
    var friendArray = [User]()
    var profileImageArray = [UIImage]()
    var selectedFriend: User?
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var challengeDescription: UITextView!
    @IBOutlet weak var challengeTitle: UITextField!
    @IBOutlet weak var createChallengeCollectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setImageView()
        
        challengeTitle.textAlignment = .Center
        challengeTitle.font = UIFont.systemFontOfSize(25)
        challengeTitle.textColor = MaterialColor.white
        challengeDescription.textColor = MaterialColor.white

        self.retrieveFriends()
        
        createChallengeCollectionView.allowsMultipleSelection = false
    }
    
    deinit
    {
        print("deinit")
    }
    
    func setImageView()
    {
        let user = FIRAuth.auth()?.currentUser
        
        let profileImageURL = user!.photoURL
        
        userImage.sd_setImageWithURL(profileImageURL)
        userImage.layer.cornerRadius = userImage.frame.size.width/2
    }
    
    func retrieveFriends()
    {
        //Pass closure as a parameter to load data being fetched asynchronously in real time
        FirebaseHelper.queryFriendObject({ [weak self] (user: User) -> Void in
            
            //Appends the user retrieved from the Database on userArray
            self?.friendArray.append(user)
            
            self?.createChallengeCollectionView.reloadData()
        })
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = createChallengeCollectionView.dequeueReusableCellWithReuseIdentifier("CreateChallengeCell", forIndexPath: indexPath) as! CreateChallengeViewCell
        
        let friend = friendArray[indexPath.row]
        let profileImageURL = NSURL(string: friend.profileImage)
        
        //Sets the information relevant to the cell on CollectionView
        cell.profileImageView!.sd_setImageWithURL(profileImageURL!)
        cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width/2
        
        cell.nameLabel?.text = friend.name
        cell.user = friend
        
        if(cell.user?.userID == selectedFriend?.userID)
        {
            cell.nameLabel.textColor = .blueColor()
        }
        else
        {
            cell.nameLabel.textColor = .whiteColor()
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return friendArray.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    //MUST MAKE CONDITION WHEN NO FRIEND IS SELECTED
    @IBAction func doneButtonPressed(sender: AnyObject)
    {
        let user = (FIRAuth.auth()?.currentUser)!
        
        //Sets all the information in constants to instantiate a Challenge object
        let challengerName = user.displayName!
        let challengerID = user.uid
        let challengerProfileImage = (user.photoURL?.absoluteString)!
        let challengeTitle: String = self.challengeTitle.text!
        let challengeDescription: String = self.challengeDescription.text!
        let foeID = selectedFriend?.userID
        let foeProfileImage = selectedFriend?.profileImage
        
        //Creates challenge
        
        if(foeID != nil)
        {
            let challenge = Challenge(challengerName: challengerName, challengerID: challengerID, challengerProfileImage: challengerProfileImage, foeID: foeID!, foeProfileImage: foeProfileImage!, challengeTitle: challengeTitle, challengeDescription: challengeDescription)
            
            challenge.uploadChallenge() //Uploads challenge to Database
        }
        else
        {
            print("Challenge not created: Friend not selected")
        }
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject)
    {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CreateChallengeViewCell
        
        selectedFriend = cell.user
        cell.nameLabel.textColor = .blueColor()
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as? CreateChallengeViewCell
        
        if let cell = cell
        {
            cell.nameLabel.textColor = .whiteColor()
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject)
    {
        view.endEditing(true)
    }
}

extension CreateChallengeViewController: UITextFieldDelegate, UITextViewDelegate
{
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        challengeTitle.resignFirstResponder()
        
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}