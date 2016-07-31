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
        dataRef.observeEventType(.ChildAdded, withBlock: { (snapshot) in
            let name = snapshot.value!["name"] as! String
            let profileImage = snapshot.value!["profileImage"] as! String
            let userID = snapshot.key
            
            let user = User(userID: userID, name: name, email: "", profileImage: profileImage)
            
            callback(user)
        })
    }
    
    static func queryFriendID(callback: (User) -> Void)
    {
        if let user = FIRAuth.auth()?.currentUser
        {
            //Creates a reference to the Firebase Database
            let friendsRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users").child(user.uid).child("Friends")
            
            //Queries the friends userID from the Database
            friendsRef.observeEventType(.ChildAdded, withBlock: { (snapshot) in
                let userID = snapshot.key
                
                queryFriendData(userID, callback: callback)
            })
        }
        else
        {
            print("No user logged in")
        }
    }
    
    static func queryFriendData(userID: String, callback: (User) -> Void)
    {
        let dataRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users")
        
        dataRef.observeEventType(.ChildAdded, withBlock: { (snapshot) in
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
        if let user = FIRAuth.auth()?.currentUser
        {
            //Creates a reference to the Firebase Database
            let challengeRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users").child(user.uid).child("Challenges")
            
            //Queries the friends userID from the Database
            challengeRef.observeEventType(.ChildAdded, withBlock: { (snapshot) in
                let challengeName = snapshot.key
                let challengerImage = snapshot.value!["ChallengerImage"] as! String
                let challengeDescription = snapshot.value!["Description"] as! String
                
                let challenge = Challenge(name: challengeName, challengerID: "", challengerProfileImage: challengerImage, foeID: "", title: challengeName, description: challengeDescription)
                
                callback(challenge)
            })
        }
        else
        {
            print("No user logged in")
        }
    
    }
    
    static func addFriend(userID: String, friendID: String, friendName: String)
    {
        let dataRef: FIRDatabaseReference = FIRDatabase.database().reference()
        dataRef.child("Users").child(userID).child("Friends").updateChildValues([friendID: friendName])
    }
}