//
//  AppDelegate.swift
//  iChallenge
//
//  Created by Gian Vitola on 7/2/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var pagedScrollViewController: PagedScrollViewController!
    var startViewController: UIViewController!
    var welcomeViewController: WelcomeViewController!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        preparePagedScrollViewController()
        prepareStartViewController()
        prepareLoginNotificationObserver()
        prepareWelcomeViewController()
        prepareWindow()
        
        // Set up the Parse SDK
        let configuration = ParseClientConfiguration {
            $0.applicationId = "ichallengeios"
            $0.server = "https://ichallengeios.herokuapp.com/parse"
        }
        Parse.initializeWithConfiguration(configuration)
        
        return true
    }
    
}
extension AppDelegate {
    
    // MARK: - Preparations
    func preparePagedScrollViewController() {
        pagedScrollViewController = PagedScrollViewController()
        pagedScrollViewController.view.frame = UIScreen.mainScreen().bounds
        
        let page = Page()
        page.backgroundColor = UIColor.whiteColor()
        
        let page1 = Page()
        page1.backgroundColor = UIColor.whiteColor()
        
        let page2 = Page()
        page2.backgroundColor = UIColor.whiteColor()
        
        pagedScrollViewController.pages = [page, page1, page2]
        
        pagedScrollViewController.delegate = self
    }
    
    func prepareStartViewController() {
        let user = PFUser.currentUser()
        
        if (user != nil) {
            // if we have a user, set the MainViewController to be the initial view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            startViewController = storyboard.instantiateViewControllerWithIdentifier("NavigationController") as! UINavigationController
        } else {
            // Otherwise set the Paged to be the initial view controller
            startViewController = pagedScrollViewController
        }
    }
    func prepareWindow() {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = startViewController
        window?.makeKeyAndVisible()
    }
    
    func prepareLoginNotificationObserver() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.login), name: "Login", object: nil)
    }
    
    func prepareWelcomeViewController() {
        let storyboard = UIStoryboard(name: "SignupLogin", bundle: nil)
        welcomeViewController = storyboard.instantiateViewControllerWithIdentifier("WelcomeViewController") as! WelcomeViewController
    }
    
    // MARK: - Helper Methods
    func login() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        startViewController = storyboard.instantiateViewControllerWithIdentifier("NavigationController") as! UINavigationController
        
        window?.rootViewController? = startViewController
        
    }
}

extension AppDelegate: PagedScrollViewControllerDelegate {
    func didPressEnterButton() {
        window?.rootViewController = welcomeViewController
        window?.makeKeyAndVisible()
    }
}
