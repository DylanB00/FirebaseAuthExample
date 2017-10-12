//
//  ChangePasswordViewController.swift
//  Connect
//
//  Created by Dylan Bolger on 10/12/17.
//  Copyright © 2017 Dylan Bolger. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class ChangePasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var changePassLabel: UILabel!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var confirmPassField: UITextField!
    @IBOutlet weak var viewPassButton: UIButton!
    @IBAction func viewPass(_ sender: Any) {
        if (passField.isSecureTextEntry == true) {
            viewPassButton.setTitle("Hide New Password" ,for: .normal)
            viewPassButton.titleLabel?.text = "View New Password"
            passField.isSecureTextEntry = false
        } else {
            viewPassButton.setTitle("View New Password" ,for: .normal)
            viewPassButton.titleLabel?.text = "Hide New Password"
            passField.isSecureTextEntry = true
        }
    }
    
    func changePass() {
        Auth.auth().currentUser?.reauthenticateAndRetrieveData(with: EmailAuthProvider.credential(withEmail: (Auth.auth().currentUser?.email)!, password: confirmPassField.text!), completion:  { (user, error) in
            if let firebaseError = error {
                print(firebaseError.localizedDescription)
                self.changePassLabel.text = firebaseError.localizedDescription
                return
            }
            Auth.auth().currentUser?.updatePassword(to: self.passField.text!, completion: { (error) in
                if (self.passField.text?.characters.count)! < 6 {
                    self.changePassLabel.text = "Password must be at least six characters."
                }
                else {
                    self.changePassLabel.text = "Success!"
                    self.passField.text = ""
                    self.confirmPassField.text = ""
                }
                
            })
        })
        
        }
        
    
    
    @IBAction func deleteAcc(_ sender: Any) {
        let alert = UIAlertController(title: "Confirm Delete", message: "Delete your account?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            let alert2 = UIAlertController(title: "Confirm Delete", message: "Are you sure you would like to delete your account? All information will be lost.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                Auth.auth().currentUser?.delete(completion: { (error) in
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginView") as UIViewController
                    self.present(viewController, animated: false, completion: nil)
                    
                })
            }))
            
            alert2.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                print("Cancelled")
            }))
            self.present(alert2, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            print("Cancelled")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func confirmPass(_ sender: Any) {
                if self.passField.isSecureTextEntry == false {
                    self.passField.isSecureTextEntry = true

            viewPassButton.setTitle("View New Password", for: .normal)
        }
        let alert = UIAlertController(title: "Confirm Password", message: "Do you wish to confirm the new account password?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.changePass()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            print("Cancelled")
            self.passField.text = ""
            self.confirmPassField.text = ""
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func returnToLogin(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signedInView") as UIViewController
        self.present(viewController, animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        passField.delegate = self
        confirmPassField.delegate = self
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
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
