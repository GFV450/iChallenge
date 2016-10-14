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
        setViewControllers([challengesView], direction: .forward, animated: false, completion: nil)
        
        
        let swiftColor = UIColor(red: 62/255, green: 53/255, blue: 118/255, alpha: 1)
        self.view.backgroundColor = swiftColor
    }
    
    
    fileprivate lazy var challengesView: MainChallengesViewController = {
        return self.storyboard!.instantiateViewController(withIdentifier: "MainChallengesViewController") as! MainChallengesViewController
    }()
    
    fileprivate lazy var completedChallengesView: MainCompletedChallengesViewController = {
        return self.storyboard!.instantiateViewController(withIdentifier: "MainCompletedChallengesViewController") as! MainCompletedChallengesViewController
    }()
    
    fileprivate lazy var friendChallengesView: MainFriendChallengesViewController = {
        return self.storyboard!.instantiateViewController(withIdentifier: "MainFriendChallengesViewController") as! MainFriendChallengesViewController
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
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        if(viewController.isKind(of: MainFriendChallengesViewController.self))
        {
            return completedChallengesView
        }
        else if(viewController.isKind(of: MainCompletedChallengesViewController.self))
        {
            return challengesView
        }
        else
        {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        if(viewController.isKind(of: MainChallengesViewController.self))
        {
            return completedChallengesView
        }
        else if(viewController.isKind(of: MainCompletedChallengesViewController.self))
        {
            return friendChallengesView
        }
        else
        {
            return nil
        }
    }
    
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
