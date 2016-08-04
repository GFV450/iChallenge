//
//  SignupViewController.swift
//  iChallenge
//
//  Created by Jake on 7/2/16.
//  Copyright © 2016 Jake Zeal. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupViewController : UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    var firstNameShake: CustomAnimation!
    var lastNameShake: CustomAnimation!
    var passwordShake: CustomAnimation!
    var emailShake: CustomAnimation!
   
    var photoTakingHelper: PhotoTakingHelper?
    
    // MARK: - IBOutlets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField:    UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - View Lifecycles
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Method initializers
        prepareTapGestureRecognizer()
        prepareFirstNameSShake()
        prepareLastNameShake()
        prepareEmailShake()
        preparePasswordShake()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
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
        // Condition required to create a new user
        if firstNameTextField.text!.characters.count > 3 && passwordTextField.text!.characters.count > 3 && emailTextField.text!.containsString("@")
        {
            createUser()
        }
        else
        {
            firstNameShake.shakeAnimation()
            lastNameShake.shakeAnimation()
            passwordShake.shakeAnimation()
            emailShake.shakeAnimation()
        }
    }
    
    func createUser()
    {
        //Unwrap optionals before pushing to Firebase Database
        let name = "\(self.firstNameTextField.text!) \(self.lastNameTextField.text!)"
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        //Creates a user in the app
        FIRAuth.auth()?.createUserWithEmail(email, password: password) { (user, error) in
            if error == nil
            {
                let userID = (user?.uid)!
                
                let newUser = User(userID: userID, name: name, email: email, profileImage: "")
                
                newUser.uploadUserData(user!, profileImage: self.profileImageView)
                
                print("User created successfully!")
            }
            else
            {
                print("User not created")
                print(error?.localizedDescription)
            }
        }
    }
    
    func changeImage() {
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
            
            self.profileImageView.image = image
        }
    }
}