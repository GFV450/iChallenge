//
//  ForgotPasswordViewController.swift
//  iChallenge
//
//  Created by Jake on 7/2/16.
//  Copyright © 2016 Jake Zeal. All rights reserved.
//

import UIKit

class ForgotPasswordViewController : UIViewController
{
    
    // MARK: - IBOutlets
    @IBOutlet weak var sendEmailButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        sendEmailButton.roundCorners()
        sendEmailButton.addShadow()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
    }
    
    // MARK: - Preparations
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - IBActions
    @IBAction func sendEmailButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject)
    {
    }
    
}
