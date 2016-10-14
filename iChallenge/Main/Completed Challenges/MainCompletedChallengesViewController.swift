//
//  MainCompletedChallengesViewController.swift
//  iChallenge
//
//  Created by Gian Vitola on 8/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit
import FirebaseAuth
import SDWebImage

class MainCompletedChallengesViewController: UIViewController
{
    var completedChallengeArray = [Challenge]()
    
    // MARK: - IBOutlets
    @IBOutlet weak var mainCompletedChallengesCollectionView: UICollectionView!
    
    // MARK: - View Lifecycles
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return completedChallengeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = mainCompletedChallengesCollectionView.dequeueReusableCell(withReuseIdentifier: "MainCompletedChallengesViewCell", for: indexPath) as! MainCompletedChallengesViewCell
        
        let challenge = completedChallengeArray[(indexPath as NSIndexPath).row]
        
        let profileImageNSURL = URL(string: challenge.challengerProfileImage)
        cell.challengerImage.sd_setImage(with: profileImageNSURL)
        cell.challengerImage.layer.cornerRadius = cell.challengerImage.frame.size.width/2
        
        cell.challengerName.text = challenge.challengerName
        cell.challengeName.text = challenge.challengeTitle
        
        cell.challenge = challenge
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "CompletedChallengeSegue"
        {
            let cell = sender as! MainCompletedChallengesViewCell
            let challengeController = segue.destination as! CompletedChallengeViewController
            
            challengeController.challenge = cell.challenge
        }
    }

    @IBAction func logoutButtonPressed(_ sender: AnyObject)
    {
        try! FIRAuth.auth()!.signOut()
    }
}
