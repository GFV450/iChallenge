//
//  SignupViewController.swift
//  iChallenge
//
//  Created by Jake on 7/2/16.
//  Copyright © 2016 Jake Zeal. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

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
        let name: String = "\(self.firstNameTextField.text!) \(self.lastNameTextField.text!)"
        
        storeProfileImage(name)
    }
    
    func storeProfileImage(name: String)
    {
        let profileImageData = UIImageJPEGRepresentation(self.profileImageView.image!, 1.0)
        
        // Create a reference to the file you want to upload
        let profileImageRef = storageRef.child("ProfileImages/uhbhubhj.jpg")
        
        // Upload the file to the path defined above
        profileImageRef.putData(profileImageData!, metadata: nil) { metadata, error in
            if (error != nil)
            {
                print("Image not stored: ", error?.localizedDescription)
            }
            else
            {
                //Stores the profile image URL and sends it to the next function
                let downloadURL = metadata!.downloadURL()
                self.storeUserData(name, profileImageURL: downloadURL!)
            }
        }
    }
    
    func storeUserData(name: String, profileImageURL: NSURL)
    {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        //Creates the user in the Firebase Authentication Database
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user, error) in
            if error == nil
            {
                
                //Stores information in database
                let uid = user?.uid
                let profileImageString = profileImageURL.absoluteString
                self.dataRef.child("Users").child(uid!).setValue(["Name": name, "Email": email, "ProfileImage": profileImageString])
                
                //Modifies information in Firebase User Profile of the current authenticated user
                let changeRequest = user!.profileChangeRequest()
                changeRequest.displayName = name
                changeRequest.photoURL = profileImageURL
                changeRequest.commitChangesWithCompletion { error in
                    if let error = error
                    {
                        print("an error happened: \(error.localizedDescription)")
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

