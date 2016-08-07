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
    let challengerName: String
    let challengerID: String
    let challengerProfileImage: String
    let foeID: String
    let challengeTitle: String
    let challengeDescription: String
    
    init(challengerName: String, challengerID: String, challengerProfileImage: String, foeID: String, challengeTitle: String, challengeDescription: String)
    {
        self.challengerName = challengerName
        self.challengerID = challengerID
        self.challengerProfileImage = challengerProfileImage
        self.foeID = foeID
        self.challengeTitle = challengeTitle
        self.challengeDescription = challengeDescription
    }
    
    // MARK: - Methods
    func uploadChallenge()
    {
        //Creates a reference to the Firebase Database
        let dataRef: FIRDatabaseReference! = FIRDatabase.database().reference()
        
        //Creates a new challenge in the foe tree
        dataRef.child("Users").child(foeID).child("Challenges").child(challengeTitle).setValue(["challengerName": challengerName, "challengerID": challengerID, "challengerProfileImage": challengerProfileImage, "foeID": foeID, "challengeDescription": challengeDescription])
    }
    
    func challengeCompleted()
    {
        let dataRef: FIRDatabaseReference! = FIRDatabase.database().reference()
        
        dataRef.child("Users").child(foeID).child("Challenges").child(challengeTitle).removeValue()
        
    dataRef.child("Users").child(foeID).child("completedChallenges").child(challengeTitle).setValue(["challengerName": challengerName, "challengerID": challengerID, "challengerProfileImage": challengerProfileImage, "foeID": foeID, "challengeDescription": challengeDescription])
        
        dataRef.child("Users").child(challengerID).child("friendChallenges").child(challengeTitle).setValue(["challengerName": challengerName, "challengerID": challengerID, "challengerProfileImage": challengerProfileImage, "foeID": foeID, "challengeDescription": challengeDescription])
    }
    
    func challengeReported()
    {
        let dataRef: FIRDatabaseReference! = FIRDatabase.database().reference()
        
        dataRef.child("Users").child(foeID).child("Challenges").child(challengeTitle).removeValue()
        
        dataRef.child("flaggedContent").child(challengeTitle).setValue(["challengerName": challengerName, "challengerID": challengerID, "challengerProfileImage": challengerProfileImage, "foeID": foeID, "challengeDescription": challengeDescription])
    }
}