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
    var storageRef: FIRStorageReference!
   
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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Firebase initializers
        dataRef = FIRDatabase.database().reference()
        storageRef = FIRStorage.storage().reference()
        
        //Method initializers
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
            createUser()
            
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
    
    func createUser()
    {
        //Unwrap optionals before pushing to Firebase Database
        let firstName: String = self.firstNameTextField.text!
        let lastName: String = self.lastNameTextField.text!
        
        storeProfileImage(firstName, lastName: lastName)
    }
    
    func storeProfileImage(firstName: String, lastName: String)
    {
        let profileImageData = UIImageJPEGRepresentation(self.profileImageView.image!, 1.0)
        
        // Create a reference to the file you want to upload
        let profileImageRef = storageRef.child("ProfileImages/\(firstName) \(lastName).jpg")
        
        // Upload the file to the path "images/rivers.jpg"
        profileImageRef.putData(profileImageData!, metadata: nil) { metadata, error in
            if (error != nil)
            {
                print("Image not stored")
            }
            else
            {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL()
                self.storeUserData(firstName, lastName: lastName, profileImageURL: downloadURL!)
            }
        }
    }
    
    func storeUserData(firstName: String, lastName: String, profileImageURL: NSURL)
    {
        //Creates the user in the Firebase Authentication Database
        FIRAuth.auth()?.createUserWithEmail(emailTextField.text!, password: passwordTextField.text! , completion: { (user, error) in
            if error == nil
            {
                let changeRequest = user!.profileChangeRequest()
                changeRequest.displayName = "\(firstName) \(lastName)"
                changeRequest.photoURL = profileImageURL
                
                changeRequest.commitChangesWithCompletion { error in
                    if let error = error
                    {
                        print("an error happened")
                    }
                    else
                    {
                        print("Profile updated")
                    }
                }
                
                print("User created successfully!")
            }
            else
            {
                print("User not created")
            }
        })

    }
    
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    // MARK: - Helper Methods
    func changeImage() {
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
    
            self.profileImageView.image = image
            
        }
    }
}

