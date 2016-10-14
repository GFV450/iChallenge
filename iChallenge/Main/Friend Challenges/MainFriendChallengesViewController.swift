//
//  MainFriendChallengesViewController.swift
//  iChallenge
//
//  Created by Gian Vitola on 8/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit
import FirebaseAuth
import SDWebImage

class MainFriendChallengesViewController: UIViewController
{
    var friendChallengeArray = [Challenge]()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var friendChallengesCollectionView: UICollectionView!
    
    
    
    // MARK: - View Lifecycles
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return friendChallengeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = friendChallengesCollectionView.dequeueReusableCell(withReuseIdentifier: "MainFriendChallengesCollectionViewCell", for: indexPath) as! MainFriendChallengesCollectionViewCell
        
        let challenge = friendChallengeArray[(indexPath as NSIndexPath).row]
        
        let profileImageNSURL = URL(string: challenge.foeProfileImage)
        cell.challengerImage.sd_setImage(with: profileImageNSURL)
        cell.challengerImage.layer.cornerRadius = cell.challengerImage.frame.size.width/2
        
        cell.challengeName.text = challenge.challengeTitle
        
        cell.challengerName.text = challenge.challengerName
        cell.challenge = challenge
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "CompletedChallengeSegue"
        {
            let cell = sender as! MainFriendChallengesCollectionViewCell
            let challengeController = segue.destination as! CompletedChallengeViewController
            
            challengeController.challenge = cell.challenge
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: AnyObject)
    {
        try! FIRAuth.auth()!.signOut()
    }
}
