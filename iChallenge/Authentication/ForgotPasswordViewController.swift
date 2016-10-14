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
        
        emailTextField.textColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Preparations
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    // MARK: - IBActions
    @IBAction func sendEmailButtonPressed(_ sender: AnyObject) {
        
    }
    
    @IBAction func dismissKeyboard(_ sender: AnyObject)
    {
        view.endEditing(true)
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        emailTextField.resignFirstResponder()
        
        return true
    }
}
