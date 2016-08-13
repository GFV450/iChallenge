//
//  ForgotPasswordViewController.swift
//  iChallenge
//
//  Created by Jake on 7/2/16.
//  Copyright © 2016 Jake Zeal. All rights reserved.
//

import UIKit
import Material

class ForgotPasswordViewController : UIViewController
{
    
    // MARK: - IBOutlets
    @IBOutlet weak var sendEmailButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - View Lifecycles
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        emailTextField.textColor = MaterialColor.white
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
        view.endEditing(true)
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        emailTextField.resignFirstResponder()
        
        return true
    }
}
