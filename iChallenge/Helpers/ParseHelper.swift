//
//  ParseHelper.swift
//  iChallenge
//
//  Created by Jake on 7/7/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import Foundation
import Parse

// change sign up to allow user to upload uiimage

class ParseHelper {
    
    static func fetchUserChallenges(completionBlock: PFQueryArrayResultBlock) {
        
        let challengesToThisUser = Challenge.query()
        challengesToThisUser?.whereKey(ParseHelperConstants.ChallengeToUser, equalTo: PFUser.currentUser()!)
        
        challengesToThisUser?.findObjectsInBackgroundWithBlock(completionBlock)
    }
    
    static func fetchChallengesToFriends(completionBlock: PFQueryArrayResultBlock) {
        
        let challengesToFriends = Challenge.query()
        challengesToFriends?.whereKey(ParseHelperConstants.ChallengeFromUser, equalTo: PFUser.currentUser()!)
        
        challengesToFriends?.findObjectsInBackgroundWithBlock(completionBlock)
    }
}
