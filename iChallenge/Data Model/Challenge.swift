//
//  Challenge.swift
//  iChallenge
//
//  Created by Jake on 7/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import Foundation
import Bond
import ConvenienceKit
import Parse

class Challenge: PFObject, PFSubclassing {
    // MARK: - Properties
    
    // Need current user, challenges associated, and its friends' challenges
    
    @NSManaged var challenger: ParseUser?
    @NSManaged var challengedUser: ParseUser?
    
    var title: Observable<String?> = Observable(nil)
    var challengeDescription: Observable<String?> = Observable(nil)
    var duration: Observable<String?> = Observable(nil)
    var isComplete: Observable<Bool?> = Observable(nil)
    
    var ongoing = []
    var completed = []
    
    var challengeUploadTask: UIBackgroundTaskIdentifier?
    
    override class func initialize() {
        registerSubclass()
    }
    
    // MARK: - PFSubclassing Protocol
    static func parseClassName() -> String {
        return "Challenge"
    }
    
    // MARK: - Helper Methods
    func uploadChallenge(title: String, description: String) {
        
        challenger = ParseUser.currentUser()
        self.title = Observable(title)
        self.challengeDescription = Observable(description)
        
        challengeUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () in
            UIApplication.sharedApplication().endBackgroundTask(self.challengeUploadTask!)
        }
        
        saveInBackgroundWithBlock() { (success: Bool, error: NSError?) in
            
            if let error = error {
                ErrorHandling.defaultErrorHandler(error)
            }
            UIApplication.sharedApplication().endBackgroundTask(self.challengeUploadTask!)
        }
    }
    
    func fetchChallenges(title: String) {
        
        guard PFUser.currentUser() != nil else {return}
        
//        ParseHelper.queryUserChallenges(PFUser.currentUser()!) { (challenges, error) in
            // If Challenge isComplete == false populate
            
            
//        }
   
        
        
        //        ParseHelper.queryUserChallenges(self, completionBlock: { (challenges, error) in
        //
        //            let validChallenges = challenges?.filter { challenge in challenge[ParseHelperConstants.LikeFromUser] != nil }
        //
        //            // map replaces the objects
        //            self.likes.value = validLikes?.map { like in
        //
        //                let fromUser = like[ParseHelperConstants.LikeFromUser] as! PFUser
        //
        //                return fromUser
        //            }
        //        })
    }
    
}

// gray background
// solid dark for buttons and titles

//left avatar challenged by "NAME"

// description should pop more

// timer much smaller

// list of things you'll need, time itll take

//this task on average takes x time clock icon beside

// Create challenge then add friend to send to or do on same screen
//avatar prepopulate
