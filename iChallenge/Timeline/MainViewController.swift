//
//  MainViewController.swift
//  iChallenge
//
//  Created by Jake on 7/2/16.
//  Copyright © 2016 Jake Zeal. All rights reserved.
//

import UIKit
import Parse

class MainViewController: UIViewController {
    
    // MARK: - Properties
    var challengesToFriends = [PFObject]?()
    var userChallenges = [PFObject]?()
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUserChallenges()
        fetchChallengesToFriends()
        
    }
    
    func fetchUserChallenges() {
        ParseHelper.fetchUserChallenges { (challenges, error) in
            self.userChallenges = challenges
        }
    }
    
    func fetchChallengesToFriends() {
        ParseHelper.fetchChallengesToFriends { (challenges, error) in
            self.challengesToFriends = challenges
        }

    }

    // MARK: - IBActions
    @IBAction func segmentedControlTapped(sender: AnyObject) {
        collectionView.reloadData()
    }
    
}

// MARK: - Collection View Data Source
extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // TODO: Return number of challenges depending on Segmented (friends' vs yours) pulling from Parse
        let userCount = 1
        let friendCount = 1
        
        let array = [userCount, friendCount]
        return array[segmentedControl.selectedSegmentIndex]
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(IdentifierConstants.ChallengeCollectionViewCellIdentifier, forIndexPath: indexPath) as! MainCollectionViewCell
        
        // Set image to Challenger user image
        // Set title to Challenge object title
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: IdentifierConstants.ChallengeCollectionViewHeader, forIndexPath: indexPath) as! MainCollectionReusableView
        
        let headerTitles = [MainViewControllerConstants.Ongoing,
                            MainViewControllerConstants.Completed]
        
        reusableView.headerLabel.text = headerTitles[indexPath.section]
        
        return reusableView
        
    }
}

