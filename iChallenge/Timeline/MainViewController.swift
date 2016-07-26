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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
}

// MARK: - Collection View Data Source
extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // TODO: Return number of challenges depending on Segmented (friends' vs yours) pulling from Firebase
        let userCount = 4
        let friendCount = 4
        
        let array = [userCount, friendCount]
        return array[segmentedControl.selectedSegmentIndex]
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChallengeCell", forIndexPath: indexPath) as! MainCollectionViewCell
        
        // Set image to Challenger user image
        // Set title to Challenge object title
        
        
        return cell
    }
}

