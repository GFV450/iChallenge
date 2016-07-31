//
//  Challenge.swift
//  iChallenge
//
//  Created by Jake on 7/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import Foundation
import Firebase

class Challenge
{
    let name: String
    let challengerID: String
    let challengerProfileImage: String
    let foeID: String
    let title: String
    let description: String
    
    init(name: String, challengerID: String, challengerProfileImage: String, foeID: String, title: String, description: String)
    {
        self.name = name
        self.challengerID = challengerID
        self.challengerProfileImage = challengerProfileImage
        self.foeID = foeID
        self.title = title
        self.description = description
    }
    
    // MARK: - Methods
    func uploadChallenge()
    {
        //Creates a reference to the Firebase Database
        let dataRef: FIRDatabaseReference! = FIRDatabase.database().reference()
        
        //Creates a new challenge in the foe tree
        dataRef.child("Users").child(foeID).child("Challenges").child(title).setValue(["Challenger": name, "ChallengerID": challengerID, "ChallengerImage": challengerProfileImage, "Description": description])
    }
    
    func fetchChallenges(title: String)
    {
        
    }
}