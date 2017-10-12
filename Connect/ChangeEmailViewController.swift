//
//  ChangeEmailViewController.swift
//  Connect
//
//  Created by Dylan Bolger on 10/12/17.
//  Copyright © 2017 Dylan Bolger. All rights reserved.
//

import UIKit
import FirebaseAuth
class ChangeEmailViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var changeEmailTitle: UILabel!
    @IBOutlet weak var newEmailField: UITextField!
    @IBOutlet weak var currentEmailField: UITextField!
    @IBOutlet weak var currentPassField: UITextField!
    @IBAction func changeEmail(_ sender: Any) {
        Auth.auth().currentUser?.reauthenticateAndRetrieveData(with: EmailAuthProvider.credential(withEmail: (currentEmailField.text)!, password: currentPassField.text!), completion:  { (user, error) in
            if let firebaseError = error {
                print(firebaseError.localizedDescription)
                self.changeEmailTitle.text = firebaseError.localizedDescription
                return
            }
            Auth.auth().currentUser?.updateEmail(to: self.newEmailField.text!, completion: { (error) in
                
                self.changeEmailTitle.text = "Success!"
                self.newEmailField.text = ""
                self.currentEmailField.text = ""
                self.currentPassField.text = ""
            })
        })
    }
    @IBAction func returnToLogin(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signedInView") as UIViewController
        self.present(viewController, animated: false, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentEmailField.delegate = self
        currentEmailField.tag = 1
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = currentEmailField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            currentEmailField.resignFirstResponder()
            
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
