//
//  MainChallengesViewController.swift
//  iChallenge
//
//  Created by Gian Vitola on 8/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit

class MainChallengesViewController: UIViewController
{
    var challengeArray = [Challenge]()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var mainChallengesCollectionView: UICollectionView!
    
    
    // MARK: - View Lifecycles
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        challengeArray.removeAll()
        self.retrieveChallenges()
    }
}

extension MainChallengesViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    func retrieveChallenges()
    {
        FirebaseHelper.queryChallenges({ (challenge: Challenge) -> Void in
            //Appends the user retrieved from the Database on userArray
            self.challengeArray.append(challenge)
            
            self.mainChallengesCollectionView.reloadData()
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
        
        let cell = mainChallengesCollectionView.dequeueReusableCellWithReuseIdentifier("MainChallengesCollectionViewCell", forIndexPath: indexPath) as! MainChallengesCollectionViewCell
        
        let challenge = challengeArray[indexPath.row]
        
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
            let cell = sender as! MainChallengesCollectionViewCell
            let challengeController = segue.destinationViewController as! ChallengeViewController
            
            challengeController.challenge = cell.challenge
        }
    }
}
