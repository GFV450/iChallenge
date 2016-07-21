//
//  FirebaseHelper.swift
//  iChallenge
//
//  Created by Gian Vitola on 7/20/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import Foundation
import Firebase

class FirebaseHelper
{
//    var userArray = [User]()
    
    func retrieveUserData(callback: (User) -> Void)
    {
        let dataRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Users")
        
        dataRef.observeEventType(.ChildAdded, withBlock: { (snapshot) in
            let name = snapshot.value!["name"] as! String
            let profileImage = snapshot.value!["profileImage"] as! String
            
            let user = User(userID: "", name: name, email: "", profileImage: profileImage)
            callback(user)
//            self.userArray.append(user)
        })
    }
}