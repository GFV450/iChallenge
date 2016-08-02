//
//  AppDelegate.swift
//  iChallenge
//
//  Created by Gian Vitola on 7/2/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit
import Parse
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        // Use Firebase library to configure APIs
        FIRApp.configure()
        
        return true
    }
}
