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
        setViewControllers([getChallengesView()], direction: .Forward, animated: false, completion: nil)
    }
    
    func getChallengesView() -> MainChallengesViewController {
        return storyboard!.instantiateViewControllerWithIdentifier("MainChallengesViewController") as! MainChallengesViewController
    }
    
    func getCompletedChallengesView() -> MainCompletedChallengesViewController {
        return storyboard!.instantiateViewControllerWithIdentifier("MainCompletedChallengesViewController") as! MainCompletedChallengesViewController
    }
    
    func getFriendChallengesView() -> MainFriendChallengesViewController {
        return storyboard!.instantiateViewControllerWithIdentifier("MainFriendChallengesViewController") as! MainFriendChallengesViewController
    }
}

extension MainPageViewController: UIPageViewControllerDataSource
{
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        if(viewController.isKindOfClass(MainFriendChallengesViewController))
        {
            return getCompletedChallengesView()
            
        }
        else if(viewController.isKindOfClass(MainCompletedChallengesViewController))
        {
            return getChallengesView()
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
            return getCompletedChallengesView()
            
        }
        else if(viewController.isKindOfClass(MainCompletedChallengesViewController))
        {
            return getFriendChallengesView()
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