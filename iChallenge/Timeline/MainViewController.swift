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
        cell.challengeDescription = challenge.description
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
        ChallengeViewController.fillChallengeScreen({ () -> (title: String, description: String, profileImage: UIImage) in
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! MainCollectionViewCell
            
            let profileImage = cell.challengerImage.image
            let title = cell.challengeName.text!
            let description = cell.challengeDescription
            
            return (title, description, profileImage)
        })
    }
    
    
}

