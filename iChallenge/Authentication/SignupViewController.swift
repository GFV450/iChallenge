//
//  SignupViewController.swift
//  iChallenge
//
//  Created by Jake on 7/2/16.
//  Copyright © 2016 Jake Zeal. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController : UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    let parseOutdated = ParseUser()
    
    var firstNameShake: CustomAnimation!
    var lastNameShake: CustomAnimation!
    var passwordShake: CustomAnimation!
    var emailShake: CustomAnimation!
    
    var dataRef: FIRDatabaseReference!
   
    var photoTakingHelper: PhotoTakingHelper?
    
    // MARK: - IBOutlets
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField:    UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        dataRef = FIRDatabase.database().reference()
        super.viewDidLoad()
        prepareTapGestureRecognizer()
        prepareFirstNameSShake()
        prepareLastNameShake()
        prepareEmailShake()
        preparePasswordShake()
    }
    
    // MARK: - Preparations
    func prepareTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignupViewController.changeImage))
        profileImageView.addGestureRecognizer(tap)
    }
    
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
    
    @IBAction func signUpButtonPressed(sender: AnyObject)
    {
        // If textfields have more than 3 characters
        if firstNameTextField.text!.characters.count > 3 && passwordTextField.text!.characters.count > 3 && emailTextField.text!.containsString("@")
        {
            //Creates the user in the Firebase Authentication Database
            FIRAuth.auth()?.createUserWithEmail(emailTextField.text!, password: passwordTextField.text! , completion: { (user, error) in
                if error == nil
                {
                    let changeRequest = user!.profileChangeRequest()
                    
                    //Unwrap optionals before pushing to Firebase Database
                    let firstName: String = self.firstNameTextField.text!
                    let lastName: String = self.lastNameTextField.text!
                    
                    changeRequest.displayName = "\(firstName) \(lastName)"
                    changeRequest.commitChangesWithCompletion { error in
                        if let error = error {
                            print("an error happened")
                        } else {
                            print("Profile updated")
                        }
                }

                    print("created successfully!")
                }
            })
//            
//                let changeRequest = user.profileChangeRequest()
//                
//                //Unwrap optionals before pushing to Firebase Database
//                let firstName: String = self.firstNameTextField.text!
//                let lastName: String = self.lastNameTextField.text!
//                
//                changeRequest.displayName = "Chase Wang"
//                changeRequest.commitChangesWithCompletion { error in
//                    if let error = error {
//                        print("an error happened")
//                    } else {
//                        print("Profile updated")
//                    }
//                }
//            }
            
            
            //Goes to Main Storyboard
            parseOutdated.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) in
                NSNotificationCenter.defaultCenter().postNotificationName("Login", object: nil)
                
            }
        }
        else
        {
            firstNameShake.shakeAnimation()
            lastNameShake.shakeAnimation()
            passwordShake.shakeAnimation()
            emailShake.shakeAnimation()
        }
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Helper Methods
    func changeImage() {
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
    
            self.profileImageView.image = image
            
        }
    }
}

