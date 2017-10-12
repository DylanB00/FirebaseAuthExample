//
//  ViewController.swift
//  Connect
//
//  Created by Dylan Bolger on 10/11/17.
//  Copyright © 2017 Dylan Bolger. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func CreateAcc(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "createAccountView") as UIViewController
        self.present(viewController, animated: false, completion: nil)
    }
    @IBAction func forgotPass(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "forgotPasswordView") as UIViewController
        self.present(viewController, animated: false, completion: nil)
    }
    func signIn() {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
            if let firebaseError = error {
                print(firebaseError.localizedDescription)
                self.titleLabel.text = firebaseError.localizedDescription
                return
            }
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signedInView") as UIViewController
            self.present(viewController, animated: false, completion: nil)
        })
    }
    
    @IBAction func Login(_ sender: Any) {
        signIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        emailField.tag = 1
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = emailField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            emailField.resignFirstResponder()
            
        }
        // Do not add a line break
        return false
    }
    @IBAction func PrimaryTrigger(_ sender: Any) {
        signIn()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
