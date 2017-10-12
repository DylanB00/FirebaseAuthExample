//
//  CreateAccountViewController.swift
//  Connect
//
//  Created by Dylan Bolger on 10/11/17.
//  Copyright © 2017 Dylan Bolger. All rights reserved.
//

import UIKit
import FirebaseAuth
class CreateAccountViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var statusTitle: UILabel!
    @IBOutlet weak var accountCreateTitle: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func returnToLogin(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginView") as UIViewController
        self.present(viewController, animated: false, completion: nil)
    }
    
    
    @IBAction func createAccountButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion:
            { (user, error) in
            if let firebaseError = error {
                print(firebaseError.localizedDescription)
                self.statusTitle.text = firebaseError.localizedDescription
                return
            }
                self.accountCreateTitle.text = "Success!"
                Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                    if let firebaseError = error {
                        print(firebaseError.localizedDescription)
                        self.statusTitle.text = firebaseError.localizedDescription
                        return
                    }
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signedInView") as UIViewController
                    self.present(viewController, animated: false, completion: nil)
                })
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldShouldReturn(emailField)
        super.viewDidLoad()
        emailField.delegate = self
        emailField.tag = 1
        // Do any additional setup after loading the view.
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
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion:
            { (user, error) in
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    self.statusTitle.text = firebaseError.localizedDescription
                    return
                }
                self.accountCreateTitle.text = "Success!"
                Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                    if let firebaseError = error {
                        print(firebaseError.localizedDescription)
                        self.statusTitle.text = firebaseError.localizedDescription
                        return
                    }
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signedInView") as UIViewController
                    self.present(viewController, animated: false, completion: nil)
                })
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
