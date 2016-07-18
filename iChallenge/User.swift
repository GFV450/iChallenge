//
//  User.swift
//  iChallenge
//
//  Created by Gian Vitola on 7/18/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class User
{
    // MARK: - Properties
    let userID: String
    let name: String
    let email: String
    let password: String
    var profileImage: NSURL
    
    init(userID: String, name: String, email: String, password: String)
    {
        self.userID = userID
        self.name = name
        self.email = email
        self.password = password
        self.profileImage = NSURL(string: "http://i.stack.imgur.com/JFf3D.png")!
    }
    
    func uploadProfileImage(profileImage: UIImageView)
    {
        // Create a reference to the path where you want to upload the file
        let storageRef: FIRStorageReference = FIRStorage.storage().reference().child("ProfileImages/\(name).jpg")
        let profileImageData = UIImageJPEGRepresentation(profileImage.image!, 1.0)
        
        // Upload the file to the path defined above
        storageRef.putData(profileImageData!, metadata: nil) { metadata, error in
            if (error != nil)
            {
                print("Image not stored: ", error?.localizedDescription)
            }
            else
            {
                //Stores the profile image URL and sends it to the next function
                let downloadURL = metadata!.downloadURL()
                self.profileImage = downloadURL!
            }
        }
    }
    
    func uploadUserData(user: FIRUser)
    {
        let dataRef: FIRDatabaseReference = FIRDatabase.database().reference()
        let profileImageString = profileImage.absoluteString
        
        dataRef.child("Users").child(self.userID).setValue(["Name": self.name, "Email": self.email, "ProfileImage": profileImageString])
        
        //Modifies information in Firebase User Profile of the current authenticated user
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = self.name
        changeRequest.photoURL = self.profileImage
        changeRequest.commitChangesWithCompletion { error in
            if let error = error
            {
                print("an error happened: \(error.localizedDescription)")
            }
            else
            {
                print("Profile updated")
            }
        }
    }
    
    func retrieveUserData()
    {
        
    }
}