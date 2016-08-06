//
//  OnboardingPageViewController.swift
//  iChallenge
//
//  Created by Gian Vitola on 8/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import Foundation
import UIKit

class OnboardingPageViewController: UIPageViewController
{
    override func viewDidLoad()
    {
        dataSource = self
        setViewControllers([getPageOne()], direction: .Forward, animated: false, completion: nil)
    }
    
    func getPageOne() -> PageOneViewController {
        return storyboard!.instantiateViewControllerWithIdentifier("PageOneViewController") as! PageOneViewController
    }
    
    func getPageTwo() -> PageTwoViewController {
        return storyboard!.instantiateViewControllerWithIdentifier("PageTwoViewController") as! PageTwoViewController
    }
    
    func getPageThree() -> PageThreeViewController {
        return storyboard!.instantiateViewControllerWithIdentifier("PageThreeViewController") as! PageThreeViewController
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource
{
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        if(viewController.isKindOfClass(PageThreeViewController))
        {
            return getPageTwo()
            
        }
        else if(viewController.isKindOfClass(PageTwoViewController))
        {
            return getPageOne()
        }
        else
        {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        if(viewController.isKindOfClass(PageOneViewController))
        {
            return getPageTwo()
            
        }
        else if(viewController.isKindOfClass(PageTwoViewController))
        {
            return getPageThree()
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
