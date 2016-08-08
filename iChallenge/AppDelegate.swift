//
//  AppDelegate.swift
//  iChallenge
//
//  Created by Gian Vitola on 7/2/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        // Use Firebase library to configure APIs
        FIRApp.configure()
        
        if let user = FIRAuth.auth()?.currentUser
        {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = mainStoryboard.instantiateViewControllerWithIdentifier("MainPageViewController")
            self.window?.rootViewController = controller
            self.window?.makeKeyAndVisible()
        }
        else
        {
            let loginStoryboard = UIStoryboard(name: "SignupLogin", bundle: nil)
            let controller = loginStoryboard.instantiateViewControllerWithIdentifier("WelcomeNavigationController")
            self.window?.rootViewController = controller
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }
}
