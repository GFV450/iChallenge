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
    static func retrieveUserData(callback: (User) -> Void)
    {
        let dataRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users")
        
        dataRef.observeEventType(.ChildAdded, withBlock: { (snapshot) in
            let name = snapshot.value!["name"] as! String
            let profileImage = snapshot.value!["profileImage"] as! String
            let userID = snapshot.key as! String
            
            let user = User(userID: userID, name: name, email: "", profileImage: profileImage)
            callback(user)
        })
    }
    
    static func addFriend(userID: String, friendID: String, friendName: String)
    {
        let dataRef: FIRDatabaseReference = FIRDatabase.database().reference()
        dataRef.child("Users").child(userID).child("Friends").updateChildValues([friendName: friendID])
    }
}