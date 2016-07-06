//
//  MainViewController.swift
//  iChallenge
//
//  Created by Jake on 7/2/16.
//  Copyright © 2016 Jake Zeal. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}

// MARK: - Collection View Data Source
extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(IdentifierConstants.ChallengeCollectionViewCellIdentifier, forIndexPath: indexPath) as! MainCollectionViewCell
        
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: IdentifierConstants.ChallengeCollectionViewHeader, forIndexPath: indexPath) as! MainCollectionReusableView
        
        switch indexPath.section {
        case 0:
            reusableView.headerLabel.text = "Your Challenges"
            break
        case 1:
            reusableView.headerLabel.text = "Friends Challenges"
            break
        default:
            reusableView.headerLabel.text = "Challenges"
        }
        
        
        
        return reusableView
    }
}

