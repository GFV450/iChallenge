//
//  WelcomeViewController.swift
//  iChallenge
//
//  Created by Jake on 7/2/16.
//  Copyright © 2016 Jake Zeal. All rights reserved.
//

import UIKit

class WelcomeViewController : UIViewController {
    
    // MARK:- Properties
    let titleLabel: UILabel = UILabel()
    var buttonShake: CustomAnimation!
    
    // MARK:- Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK:- View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavigationBar()
    }
    
    // MARK:- Preparations
    func prepareNavigationBar() {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK:- Actions
    @IBAction func signUpButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
    }
}


