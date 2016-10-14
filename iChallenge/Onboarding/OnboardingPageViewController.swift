//
//  OnboardingPageViewController.swift
//  iChallenge
//
//  Created by Gian Vitola on 8/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit

class OnboardingPageViewController: UIPageViewController
{
    override func viewDidLoad()
    {
        dataSource = self
        setViewControllers([getPageOne()], direction: .forward, animated: false, completion: nil)
    }
    
    func getPageOne() -> PageOneViewController {
        return storyboard!.instantiateViewController(withIdentifier: "PageOneViewController") as! PageOneViewController
    }
    
    func getPageTwo() -> PageTwoViewController {
        return storyboard!.instantiateViewController(withIdentifier: "PageTwoViewController") as! PageTwoViewController
    }
    
    func getPageThree() -> PageThreeViewController {
        return storyboard!.instantiateViewController(withIdentifier: "PageThreeViewController") as! PageThreeViewController
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        if(viewController.isKind(of: PageThreeViewController.self))
        {
            return getPageTwo()
            
        }
        else if(viewController.isKind(of: PageTwoViewController.self))
        {
            return getPageOne()
        }
        else
        {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        if(viewController.isKind(of: PageOneViewController.self))
        {
            return getPageTwo()
            
        }
        else if(viewController.isKind(of: PageTwoViewController.self))
        {
            return getPageThree()
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
