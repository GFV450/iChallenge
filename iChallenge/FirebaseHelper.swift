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
    
    static func addFriend(userID: String, friendID: String, friendName: String)
    {
        let dataRef: FIRDatabaseReference = FIRDatabase.database().reference()
        dataRef.child("Users").child(userID).child("Friends").updateChildValues([friendName: friendID])
    }
}