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
    let title: String
    let description: String
    
    init(name: String, challengerID: String, title: String, description: String)
    {
        self.name = name
        self.challengerID = challengerID
        self.title = title
        self.description = description
        
    }
    
    // MARK: - Methods
    func uploadChallenge()
    {
        //Creates a reference to the Firebase Database
        let dataRef: FIRDatabaseReference! = FIRDatabase.database().reference()
        
        //Creates a new challenge
        dataRef.child("Users").child(challengerID).child("Challenges").child(title).setValue(["Challenger": name, "Description": description])
    }
    
    func fetchChallenges(title: String)
    {
        
    }
}