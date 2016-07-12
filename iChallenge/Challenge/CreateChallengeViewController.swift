//
//  CreateChallengeViewController.swift
//  iChallenge
//
//  Created by Jake on 7/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit
import Firebase

class CreateChallengeViewController: UIViewController
{
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var challengeDuration: UITextField!
    @IBOutlet weak var challengeDescription: UITextView!
    @IBOutlet weak var challengeTitle: UITextField!
    @IBOutlet weak var createChallengeCollectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        changeImageView()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func changeImageView()
    {
        userImage.layer.cornerRadius = 8.0
        userImage.clipsToBounds = true
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = createChallengeCollectionView.dequeueReusableCellWithReuseIdentifier(IdentifierConstants.CreateChallengeCollectionViewCellIdentifier, forIndexPath: indexPath) as! ChallengeViewCell        
        
        cell.nameLabel.text = "Gian"
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 8
    }



    @IBAction func createChallengeButtonPressed(sender: AnyObject)
    {
        
        let titleString = challengeTitle.text
        let descriptionString = challengeDescription.text
        let durationString = challengeDuration.text
        
        var ref = FIRDatabase.database().reference()
        
        
    }
}
