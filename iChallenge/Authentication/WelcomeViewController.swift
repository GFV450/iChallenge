//
//  WelcomeViewController.swift
//  iChallenge
//
//  Created by Jake on 7/2/16.
//  Copyright © 2016 Jake Zeal. All rights reserved.
//

import UIKit
import Firebase
import Material

class WelcomeViewController : UIViewController {
    
    // MARK:- Properties
    let titleLabel: UILabel = UILabel()
    var buttonShake: CustomAnimation!
    
    // MARK:- Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK:- View Lifecycles
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        emailTextField.textColor = MaterialColor.white
        passwordTextField.textColor = MaterialColor.white
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = true
    }
    
    // MARK:- Actions
    @IBAction func loginButtonPressed(sender: AnyObject)
    {
        //Authenticates user
        FIRAuth.auth()?.signInWithEmail(emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            if error == nil
            {
                print("login successful!")
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = mainStoryboard.instantiateViewControllerWithIdentifier("MainPageViewController")
                self.presentViewController(controller, animated: true, completion: nil)
            }
            else
            {
                print("No user signed in")
            }
        })

    }
    
    @IBAction func unwindToWelcomeViewController(unwindSegue: UIStoryboard){
        
    }
}


