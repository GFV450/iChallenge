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
    let userID: String
    let title: String
    let description: String
    let duration: String
    
    init(name: String, userID: String, title: String, description: String, duration: String)
    {
        self.name = name
        self.userID = userID
        self.title = title
        self.description = description
        self.duration = duration
        
    }
    
    // MARK: - Methods
    func uploadChallenge()
    {
        //Creates a reference to the Firebase Database
        let dataRef: FIRDatabaseReference! = FIRDatabase.database().reference()
        
        //Creates a new challenge
        dataRef.child("Users").child(userID).child("Challenges").child(title).setValue(["Challenger": name, "Description": description, "Duration": duration])
    }
    
    func fetchChallenges(title: String)
    {
        
    }
}