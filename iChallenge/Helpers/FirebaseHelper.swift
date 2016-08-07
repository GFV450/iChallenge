//
//  FirebaseHelper.swift
//  iChallenge
//
//  Created by Gian Vitola on 7/20/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import Firebase

class FirebaseHelper
{
    static func queryUserData(callback: (User) -> Void)
    {
        //Creates a reference to the Firebase Database
        let dataRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users")
        
        //Queries the information needed from the Database
        dataRef.queryOrderedByChild("name").observeEventType(.ChildAdded, withBlock: { (snapshot) in
            let name = snapshot.value!["name"] as! String
            let profileImage = snapshot.value!["profileImage"] as! String
            let userID = snapshot.key
            
            let user = User(userID: userID, name: name, email: "", profileImage: profileImage)
            
            callback(user)
        })
    }
    
    static func queryFriendID(callback: (String) -> Void)
    {
        let user = (FIRAuth.auth()?.currentUser)!
        
        //Creates a reference to the Firebase Database
        let friendsRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users").child(user.uid).child("Friends")
        
        //Queries the friends userID from the Database
        friendsRef.observeEventType(.ChildAdded, withBlock: { (snapshot) in
            let userID = snapshot.key
            
            callback(userID)
        })

    }
    
    static func queryFriendObject(callback: (User) -> Void)
    {
        let user = (FIRAuth.auth()?.currentUser)!
        
        //Creates a reference to the Firebase Database
        let friendsRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users").child(user.uid).child("Friends")
        
        //Queries the friends userID from the Database
        friendsRef.observeEventType(.ChildAdded, withBlock: { (snapshot) in
            let userID = snapshot.key
            
            queryFriendData(userID, callback: callback)
        })
    }
    
    static func queryFriendData(userID: String, callback: (User) -> Void)
    {
        let dataRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users")
        
        dataRef.queryOrderedByChild("name").observeEventType(.ChildAdded, withBlock: { (snapshot) in
            if(userID == snapshot.key)
            {
                let name = snapshot.value!["name"] as! String
                let profileImage = snapshot.value!["profileImage"] as! String
                let userID = snapshot.key
                
                let user = User(userID: userID, name: name, email: "", profileImage: profileImage)
                
                callback(user)
            }
        })
    }
    
    static func queryChallenges(callback: (Challenge) -> Void)
    {
        let user = (FIRAuth.auth()?.currentUser)!
        
        //Creates a reference to the Firebase Database
        let challengeRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users").child(user.uid).child("Challenges")
        
        //Queries the challenges from the Database
        challengeRef.queryOrderedByChild("challengeTitle").observeEventType(.ChildAdded, withBlock: { (snapshot) in
            let challengerName = snapshot.value!["challengerName"] as! String
            let challengerID = snapshot.value!["challengerID"] as! String
            let challengeTitle = snapshot.key
            let challengerProfileImage = snapshot.value!["challengerProfileImage"] as! String
            let challengeDescription = snapshot.value!["challengeDescription"] as! String
            let foeID = snapshot.value!["foeID"] as! String
            
            let challenge = Challenge(challengerName: challengerName, challengerID: challengerID, challengerProfileImage: challengerProfileImage, foeID: foeID, challengeTitle: challengeTitle, challengeDescription: challengeDescription)
            
            callback(challenge)
        })
    }
    
    static func queryCompletedChallenges(callback: (Challenge) -> Void)
    {
        let user = (FIRAuth.auth()?.currentUser)!
        
        //Creates a reference to the Firebase Database
        let challengeRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users").child(user.uid).child("completedChallenges")
        
        //Queries the completed challenges from the Database
        challengeRef.queryOrderedByChild("challengeTitle").observeEventType(.ChildAdded, withBlock: { (snapshot) in
            let challengerName = snapshot.value!["challengerName"] as! String
            let challengerID = snapshot.value!["challengerID"] as! String
            let challengeTitle = snapshot.key
            let challengerProfileImage = snapshot.value!["challengerProfileImage"] as! String
            let challengeDescription = snapshot.value!["challengeDescription"] as! String
            let foeID = snapshot.value!["foeID"] as! String
            
            let challenge = Challenge(challengerName: challengerName, challengerID: challengerID, challengerProfileImage: challengerProfileImage, foeID: foeID, challengeTitle: challengeTitle, challengeDescription: challengeDescription)
            
            callback(challenge)
        })
    }
    
    static func queryFriendChallenges(callback: (Challenge) -> Void)
    {
        let user = (FIRAuth.auth()?.currentUser)!
        
        //Creates a reference to the Firebase Database
        let challengeRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users").child(user.uid).child("friendChallenges")
        
        //Queries the completed challenges from the Database
        challengeRef.queryOrderedByChild("challengeTitle").observeEventType(.ChildAdded, withBlock: { (snapshot) in
            let challengerName = snapshot.value!["challengerName"] as! String
            let challengerID = snapshot.value!["challengerID"] as! String
            let challengeTitle = snapshot.key
            let challengerProfileImage = snapshot.value!["challengerProfileImage"] as! String
            let challengeDescription = snapshot.value!["challengeDescription"] as! String
            let foeID = snapshot.value!["foeID"] as! String
            
            let challenge = Challenge(challengerName: challengerName, challengerID: challengerID, challengerProfileImage: challengerProfileImage, foeID: foeID, challengeTitle: challengeTitle, challengeDescription: challengeDescription)
            
            callback(challenge)
        })
    }


    
    static func addFriend(userID: String, friendID: String, friendName: String)
    {
        let dataRef: FIRDatabaseReference = FIRDatabase.database().reference()
        dataRef.child("Users").child(userID).child("Friends").updateChildValues([friendID: friendName])
    }
    
    static func removeFriend(userID: String, friendID: String)
    {
        let dataRef: FIRDatabaseReference = FIRDatabase.database().reference()
        dataRef.child("Users").child(userID).child("Friends").child(friendID).removeValue()
    }
}