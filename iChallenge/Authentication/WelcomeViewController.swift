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

class WelcomeViewController : UIViewController
{
    
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
        
        
        emailTextField.textColor = .white
        passwordTextField.textColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK:- Actions
    @IBAction func loginButtonPressed(_ sender: AnyObject)
    {
        //Authenticates user
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            if error == nil
            {
                print("login successful!")
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = mainStoryboard.instantiateViewController(withIdentifier: "MainPageViewController")
                self.show(controller, sender: nil)
            }
            else
            {
                print("No user signed in")
            }
        })

    }
    
    @IBAction func dismissKeyboard(_ sender: AnyObject)
    {
        self.view.endEditing(true)
    }
}

extension WelcomeViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}


