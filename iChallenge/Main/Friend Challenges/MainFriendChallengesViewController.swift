//
//  MainFriendChallengesViewController.swift
//  iChallenge
//
//  Created by Gian Vitola on 8/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit

class MainFriendChallengesViewController: UIViewController
{
    var friendChallengeArray = [Challenge]()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var friendChallengesCollectionView: UICollectionView!
    
    
    
    // MARK: - View Lifecycles
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        friendChallengeArray.removeAll()
        self.retrieveFriendChallenges()
    }
}

extension MainFriendChallengesViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func retrieveFriendChallenges()
    {
        FirebaseHelper.queryFriendChallenges({ (challenge: Challenge) -> Void in
            //Appends the user retrieved from the Database on userArray
            self.friendChallengeArray.append(challenge)
            
            self.friendChallengesCollectionView.reloadData()
        })
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return friendChallengeArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = friendChallengesCollectionView.dequeueReusableCellWithReuseIdentifier("MainFriendChallengesCollectionViewCell", forIndexPath: indexPath) as! MainFriendChallengesCollectionViewCell
        
        let challenge = friendChallengeArray[indexPath.row]
        
        let profileImageNSURL = NSURL(string: challenge.challengerProfileImage)
        cell.challengerImage.af_setImageWithURL(profileImageNSURL!)
        cell.challengerImage.image? = (cell.challengerImage.image?.af_imageRoundedIntoCircle())!
        
        cell.challengeName.text = challenge.challengeTitle
        
        cell.challenge = challenge
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ChallengeSegue"
        {
            let cell = sender as! MainFriendChallengesCollectionViewCell
            let challengeController = segue.destinationViewController as! ChallengeViewController
            
            challengeController.challenge = cell.challenge
        }
    }
}