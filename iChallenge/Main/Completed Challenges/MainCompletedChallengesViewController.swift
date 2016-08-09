//
//  MainCompletedChallengesViewController.swift
//  iChallenge
//
//  Created by Gian Vitola on 8/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainCompletedChallengesViewController: UIViewController
{
    var completedChallengeArray = [Challenge]()
    
    // MARK: - IBOutlets
    @IBOutlet weak var mainCompletedChallengesCollectionView: UICollectionView!
    
    // MARK: - View Lifecycles
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        completedChallengeArray.removeAll()
        self.retrieveCompletedChallenges()
    }
}

extension MainCompletedChallengesViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    func retrieveCompletedChallenges()
    {
        FirebaseHelper.queryCompletedChallenges({ (challenge: Challenge) -> Void in
            //Appends the user retrieved from the Database on userArray
            self.completedChallengeArray.append(challenge)
            
            self.mainCompletedChallengesCollectionView.reloadData()
        })
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return completedChallengeArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = mainCompletedChallengesCollectionView.dequeueReusableCellWithReuseIdentifier("MainCompletedChallengesViewCell", forIndexPath: indexPath) as! MainCompletedChallengesViewCell
        
        let challenge = completedChallengeArray[indexPath.row]
        
        let profileImageNSURL = NSURL(string: challenge.challengerProfileImage)
        cell.challengerImage.af_setImageWithURL(profileImageNSURL!)
        cell.challengerImage.layer.cornerRadius = cell.challengerImage.frame.size.width/2
        
        cell.challengerName.text = challenge.challengerName
        cell.challengeName.text = challenge.challengeTitle
        
        cell.challenge = challenge
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "CompletedChallengeSegue"
        {
            let cell = sender as! MainCompletedChallengesViewCell
            let challengeController = segue.destinationViewController as! CompletedChallengeViewController
            
            challengeController.challenge = cell.challenge
        }
    }

    @IBAction func logoutButtonPressed(sender: AnyObject)
    {
        try! FIRAuth.auth()!.signOut()
    }
}
