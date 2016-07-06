//
//  SignupViewController.swift
//  iChallenge
//
//  Created by Jake on 7/2/16.
//  Copyright © 2016 Jake Zeal. All rights reserved.
//

import UIKit
import Parse

class SignupViewController : UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    var firstNameShake: CustomAnimation!
    var lastNameShake: CustomAnimation!
    var passwordShake: CustomAnimation!
    var emailShake: CustomAnimation!
    
    // MARK: - IBOutlets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField:    UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareFirstNameSShake()
        prepareLastNameShake()
        prepareEmailShake()
        preparePasswordShake()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    // MARK: - Preparations
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func prepareFirstNameSShake() {
        firstNameShake = CustomAnimation(view: firstNameTextField, delay: 0, direction: .Left, repetitions: 4, maxRotation: 0, maxPosition: 10, duration: 0.1)
    }
    
    func prepareLastNameShake() {
        lastNameShake = CustomAnimation(view: lastNameTextField, delay: 0, direction: .Left, repetitions: 4, maxRotation: 0, maxPosition: 10, duration: 0.1)
    }
    
    func preparePasswordShake() {
        passwordShake = CustomAnimation(view: passwordTextField, delay: 0, direction: .Left, repetitions: 4, maxRotation: 0, maxPosition: 10, duration: 0.1)
    }
    
    func prepareEmailShake() {
        emailShake = CustomAnimation(view: emailTextField, delay: 0, direction: .Left, repetitions: 4, maxRotation: 0, maxPosition: 10, duration: 0.1)
    }
    
    // MARK: - IBActions
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func signUpButtonPressed(sender: AnyObject) {
        
//        let firstName = firstNameTextField.text ?? ""
//        let lastName = lastNameTextField.text ?? ""
//        
//        let username = firstName + lastName
//        print(username)
//        
//        let password = passwordTextField.text ?? ""
//        let email = emailTextField.text ?? ""
//        
//        // if textfields aren't empty and have more than 6 characters
//        
//        if firstName.characters.count > 3 && password.characters.count > 3 && email.containsString("@") {
//            let user = PFUser()
//            user.username = firstName
//            user.password = password
//            user.email = email
//            
//            user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) in
                // set current user and switch to MainViewController
                NSNotificationCenter.defaultCenter().postNotificationName("Login", object: nil)
//            }
//    
//        } else {
//            firstNameShake.shakeAnimation()
//            lastNameShake.shakeAnimation()
//            passwordShake.shakeAnimation()
//            emailShake.shakeAnimation()
//        }
    }
}
