//
//  ForgotPasswordViewController.swift
//  Connect
//
//  Created by Dylan Bolger on 10/11/17.
//  Copyright © 2017 Dylan Bolger. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordResetTitle: UILabel!
    @IBOutlet weak var passwordResetButton: UIButton!
    @IBAction func returnToLogin(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginView") as UIViewController
        self.present(viewController, animated: false, completion: nil)
    }
    @IBAction func passwordReset(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: emailField.text!) { (error) in
            self.passwordResetTitle.text = "Password Reset Sent!"
            self.passwordResetButton.isEnabled = false
            self.passwordResetButton.setTitleColor(UIColor.lightText, for: .normal)
            self.emailField.isEnabled = false
            }
        }
    
    override func viewDidLoad() {
        
        passwordResetButton.isEnabled = true
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
