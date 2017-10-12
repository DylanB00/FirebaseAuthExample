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
    @IBOutlet weak var viewPassButton: UIButton!
    @IBAction func viewPass(_ sender: Any) {
        if (passField.isSecureTextEntry == true) {
            viewPassButton.setTitle("Hide Password" ,for: .normal)
            viewPassButton.titleLabel?.text = "View Password"
            passField.isSecureTextEntry = false
        } else {
            viewPassButton.setTitle("View Password" ,for: .normal)
            viewPassButton.titleLabel?.text = "Hide Password"
            passField.isSecureTextEntry = true
        }
    }
    
    func changePass() {
        Auth.auth().currentUser?.updatePassword(to: passField.text!, completion: { (error) in
            if (self.passField.text?.characters.count)! < 6 {
                self.changePassLabel.text = "Password must be at least six characters."
            }
            else {
                self.changePassLabel.text = "Success!"
                self.passField.text = ""
            }
            
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

            viewPassButton.setTitle("View Password", for: .normal)
        }
        let alert = UIAlertController(title: "Confirm Password", message: "Do you wish to confirm the new account password?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.changePass()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            print("Cancelled")
            self.passField.text = ""
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func returnToLogin(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signedInView") as UIViewController
        self.present(viewController, animated: false, completion: nil)
    }
    override func viewDidLoad() {
        textFieldShouldReturn(passField)
        super.viewDidLoad()
        passField.delegate = self
        passField.tag = 1
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = passField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            passField.resignFirstResponder()
            
        }
        // Do not add a line break
        return false
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
