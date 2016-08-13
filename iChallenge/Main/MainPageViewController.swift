//
//  MainPageViewController.swift
//  iChallenge
//
//  Created by Gian Vitola on 8/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit

class MainPageViewController: UIPageViewController
{
    override func viewDidLoad()
    {
        dataSource = self
        setViewControllers([challengesView], direction: .Forward, animated: false, completion: nil)
        
        
        let swiftColor = UIColor(red: 62/255, green: 53/255, blue: 118/255, alpha: 1)
        self.view.backgroundColor = swiftColor
    }
    
    
    private lazy var challengesView: MainChallengesViewController = {
        return self.storyboard!.instantiateViewControllerWithIdentifier("MainChallengesViewController") as! MainChallengesViewController
    }()
    
    private lazy var completedChallengesView: MainCompletedChallengesViewController = {
        return self.storyboard!.instantiateViewControllerWithIdentifier("MainCompletedChallengesViewController") as! MainCompletedChallengesViewController
    }()
    
    private lazy var friendChallengesView: MainFriendChallengesViewController = {
        return self.storyboard!.instantiateViewControllerWithIdentifier("MainFriendChallengesViewController") as! MainFriendChallengesViewController
    }()
    
//    func getChallengesView() -> MainChallengesViewController {
//        return storyboard!.instantiateViewControllerWithIdentifier("MainChallengesViewController") as! MainChallengesViewController
//    }
//    
//    func getCompletedChallengesView() -> MainCompletedChallengesViewController {
//        return storyboard!.instantiateViewControllerWithIdentifier("MainCompletedChallengesViewController") as! MainCompletedChallengesViewController
//    }
    
//    func getFriendChallengesView() -> MainFriendChallengesViewController {
//        return storyboard!.instantiateViewControllerWithIdentifier("MainFriendChallengesViewController") as! MainFriendChallengesViewController
//    }
}

extension MainPageViewController: UIPageViewControllerDataSource
{
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        if(viewController.isKindOfClass(MainFriendChallengesViewController))
        {
            return completedChallengesView
        }
        else if(viewController.isKindOfClass(MainCompletedChallengesViewController))
        {
            return challengesView
        }
        else
        {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        if(viewController.isKindOfClass(MainChallengesViewController))
        {
            return completedChallengesView
        }
        else if(viewController.isKindOfClass(MainCompletedChallengesViewController))
        {
            return friendChallengesView
        }
        else
        {
            return nil
        }
    }
    
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}