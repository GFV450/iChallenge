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
    var profileImage: String
    
    init(userID: String, name: String, email: String, profileImage: String)
    {
        self.userID = userID
        self.name = name
        self.email = email
        self.profileImage = profileImage
    }
    
    func uploadUserData(user: FIRUser, profileImage: UIImageView)
    {
        // Create a reference to the path where you want to upload the file
        let storageRef: FIRStorageReference = FIRStorage.storage().reference().child("ProfileImages/\(name).jpg")
        
        //Resizes and compresses the image to be uploaded
        let resizedImage = imageConversionHelper.ResizeImage(profileImage.image!, targetSize: CGSizeMake(300.0, 300.0))
        let profileImageData = UIImageJPEGRepresentation(resizedImage, 1)
        
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
                self.uploadProfileData(user, profileImageURL: downloadURL!)
                
            }
        }
    }
    
    func uploadProfileData(user: FIRUser, profileImageURL: NSURL)
    {
        let dataRef: FIRDatabaseReference = FIRDatabase.database().reference()
        self.profileImage = profileImageURL.absoluteString
        
        dataRef.child("Users").child(self.userID).setValue(["name": self.name, "email": self.email, "profileImage": self.profileImage])
        
        //Modifies information in Firebase User Profile of the current authenticated user
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = self.name
        changeRequest.photoURL = profileImageURL
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
}