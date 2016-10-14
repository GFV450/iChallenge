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
    static func queryUserData(_ callback: @escaping (User) -> Void)
    {
        let loggedUser = (FIRAuth.auth()?.currentUser)!
        
        //Creates a reference to the Firebase Database
        let dataRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users")
        
        //Queries the information needed from the Database
        dataRef.queryOrdered(byChild: "name").observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as! NSDictionary
            
            let name = snapshotValue["name"] as! String
            let profileImage = snapshotValue["profileImage"] as! String
            let userID = snapshot.key
            
            let user = User(userID: userID, name: name, email: "", profileImage: profileImage)
            
            //Avoids displaying the logged in user in the friend search table view
            if(loggedUser.uid != user.userID)
            {
                callback(user)
            }
        })
    }
    
    static func queryFriendID(_ callback: @escaping (String) -> Void)
    {
        let user = (FIRAuth.auth()?.currentUser)!
        
        //Creates a reference to the Firebase Database
        let friendsRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users").child(user.uid).child("Friends")
        
        //Queries the friends userID from the Database
        friendsRef.queryOrdered(byChild: "name").observe(.childAdded, with: { (snapshot) in
            let userID = snapshot.key
            
            callback(userID)
        })

    }
    
    static func queryFriendObject(_ callback: @escaping (User) -> Void)
    {
        let user = (FIRAuth.auth()?.currentUser)!
        
        //Creates a reference to the Firebase Database
        let friendsRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users").child(user.uid).child("Friends")
        
        //Queries the friends userID from the Database
        friendsRef.observe(.childAdded, with: { (snapshot) in
            let userID = snapshot.key
            
            queryFriendData(userID, callback: callback)
        })
    }
    
    static func queryFriendData(_ userID: String, callback: @escaping (User) -> Void)
    {
        let dataRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users")
        
        dataRef.queryOrdered(byChild: "name").observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as! NSDictionary
            
            if(userID == snapshot.key)
            {
                let name = snapshotValue["name"] as! String
                let profileImage = snapshotValue["profileImage"] as! String
                let userID = snapshot.key
                
                let user = User(userID: userID, name: name, email: "", profileImage: profileImage)
                
                callback(user)
            }
        })
    }
    
    static func queryChallenges(_ callback: @escaping (Challenge) -> Void)
    {
        let user = (FIRAuth.auth()?.currentUser)!
        
        //Creates a reference to the Firebase Database
        let challengeRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users").child(user.uid).child("Challenges")
        
        //Queries the challenges from the Database
        challengeRef.queryOrdered(byChild: "challengeTitle").observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as! NSDictionary
            
            let challengerName = snapshotValue["challengerName"] as! String
            let challengerID = snapshotValue["challengerID"] as! String
            let challengeTitle = snapshot.key
            let challengerProfileImage = snapshotValue["challengerProfileImage"] as! String
            let challengeDescription = snapshotValue["challengeDescription"] as! String
            let foeID = snapshotValue["foeID"] as! String
            let foeProfileImage = snapshotValue["foeProfileImage"] as! String
            
            let challenge = Challenge(challengerName: challengerName, challengerID: challengerID, challengerProfileImage: challengerProfileImage, foeID: foeID, foeProfileImage: foeProfileImage, challengeTitle: challengeTitle, challengeDescription: challengeDescription)
            
            callback(challenge)
        })
    }
    
    static func queryCompletedChallenges(_ callback: @escaping (Challenge) -> Void)
    {
        let user = (FIRAuth.auth()?.currentUser)!
        
        //Creates a reference to the Firebase Database
        let challengeRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users").child(user.uid).child("completedChallenges")
        
        //Queries the completed challenges from the Database
        challengeRef.queryOrdered(byChild: "challengeTitle").observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as! NSDictionary
            
            let challengerName = snapshotValue["challengerName"] as! String
            let challengerID = snapshotValue["challengerID"] as! String
            let challengeTitle = snapshot.key
            let challengerProfileImage = snapshotValue["challengerProfileImage"] as! String
            let challengeDescription = snapshotValue["challengeDescription"] as! String
            let foeID = snapshotValue["foeID"] as! String
            let foeProfileImage = snapshotValue["foeProfileImage"] as! String
            
            let challenge = Challenge(challengerName: challengerName, challengerID: challengerID, challengerProfileImage: challengerProfileImage, foeID: foeID, foeProfileImage: foeProfileImage, challengeTitle: challengeTitle, challengeDescription: challengeDescription)
            
            callback(challenge)
        })
    }
    
    static func queryFriendChallenges(_ callback: @escaping (Challenge) -> Void)
    {
        let user = (FIRAuth.auth()?.currentUser)!
        
        //Creates a reference to the Firebase Database
        let challengeRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users").child(user.uid).child("friendChallenges")
        
        //Queries the completed challenges from the Database
        challengeRef.queryOrdered(byChild: "challengeTitle").observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as! NSDictionary
            
            let challengerName = snapshotValue["challengerName"] as! String
            let challengerID = snapshotValue["challengerID"] as! String
            let challengeTitle = snapshot.key
            let challengerProfileImage = snapshotValue["challengerProfileImage"] as! String
            let challengeDescription = snapshotValue["challengeDescription"] as! String
            let foeID = snapshotValue["foeID"] as! String
            let foeProfileImage = snapshotValue["foeProfileImage"] as! String
            
            let challenge = Challenge(challengerName: challengerName, challengerID: challengerID, challengerProfileImage: challengerProfileImage, foeID: foeID, foeProfileImage: foeProfileImage, challengeTitle: challengeTitle, challengeDescription: challengeDescription)
            
            callback(challenge)
        })
    }

    static func addFriend(_ userID: String, friendID: String, friendName: String)
    {
        let dataRef: FIRDatabaseReference = FIRDatabase.database().reference()
        dataRef.child("Users").child(userID).child("Friends").updateChildValues([friendID: friendName])
    }
    
    static func removeFriend(_ userID: String, friendID: String)
    {
        let dataRef: FIRDatabaseReference = FIRDatabase.database().reference()
        dataRef.child("Users").child(userID).child("Friends").child(friendID).removeValue()
    }
}
