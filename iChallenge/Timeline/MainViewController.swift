//
//  MainViewController.swift
//  iChallenge
//
//  Created by Jake on 7/2/16.
//  Copyright © 2016 Jake Zeal. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{
    var challengeArray = [Challenge]()
    
    // MARK: - IBOutlets
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    // MARK: - View Lifecycles
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.retrieveChallenges()
    }
}

// MARK: - Collection View Data Source
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func retrieveChallenges()
    {
        FirebaseHelper.queryChallenges({ (challenge: Challenge) -> Void in
            //Appends the user retrieved from the Database on userArray
            self.challengeArray.append(challenge)
            
            self.mainCollectionView.reloadData()
        })
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return challengeArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = mainCollectionView.dequeueReusableCellWithReuseIdentifier("ChallengeCell", forIndexPath: indexPath) as! MainCollectionViewCell
        
        let challenge = challengeArray[indexPath.row]
        
        let profileImageNSURL = NSURL(string: challenge.challengerProfileImage)
        cell.challengerImage.af_setImageWithURL(profileImageNSURL!)
        
        cell.challengeName.text = challenge.title
        cell.label.text = challenge.description
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! MainCollectionViewCell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ChallengeSegue"
        {
            let cell = sender as! MainCollectionViewCell
            let challengeController = segue.destinationViewController as! ChallengeViewController
            
            challengeController.userImageView = cell.challengerImage
            challengeController.challengeTitle = cell.challengeName
            challengeController.challengeDescription = cell.label
        }
    }

}

