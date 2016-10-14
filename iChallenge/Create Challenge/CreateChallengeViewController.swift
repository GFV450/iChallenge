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
        
        challengeTitle.textAlignment = .center
        challengeTitle.font = UIFont.systemFont(ofSize: 25)
        challengeTitle.textColor = .white
        challengeDescription.textColor = .white

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
        
        userImage.sd_setImage(with: profileImageURL)
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

    func collectionView(_ collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = createChallengeCollectionView.dequeueReusableCell(withReuseIdentifier: "CreateChallengeCell", for: indexPath) as! CreateChallengeViewCell
        
        let friend = friendArray[(indexPath as NSIndexPath).row]
        let profileImageURL = URL(string: friend.profileImage)
        
        //Sets the information relevant to the cell on CollectionView
        cell.profileImageView!.sd_setImage(with: profileImageURL!)
        cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width/2
        
        cell.nameLabel?.text = friend.name
        cell.user = friend
        
        if(cell.user?.userID == selectedFriend?.userID)
        {
//            cell.nameLabel.textColor = .blueColor()
            cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 10)
        }
        else
        {
//            cell.nameLabel.textColor = .whiteColor()
            cell.nameLabel.font = UIFont.systemFont(ofSize: 10)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return friendArray.count
    }
    
    func numberOfSectionsInCollectionView(_ collectionView: UICollectionView) -> Int {
        return 1
    }

    //MUST MAKE CONDITION WHEN NO FRIEND IS SELECTED
    @IBAction func doneButtonPressed(_ sender: AnyObject)
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
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject)
    {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as! CreateChallengeViewCell
        
        selectedFriend = cell.user
        cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 10)
//        cell.nameLabel.textColor = .blueColor()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as? CreateChallengeViewCell
        
        if let cell = cell
        {
            cell.nameLabel.font = UIFont.systemFont(ofSize: 10)
//            cell.nameLabel.textColor = .whiteColor()
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: AnyObject)
    {
        view.endEditing(true)
    }
}

extension CreateChallengeViewController: UITextFieldDelegate, UITextViewDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        challengeTitle.resignFirstResponder()
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
