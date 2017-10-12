//
//  SignedInViewController.swift
//  Connect
//
//  Created by Dylan Bolger on 10/11/17.
//  Copyright © 2017 Dylan Bolger. All rights reserved.
//

import UIKit
import FirebaseAuth
class SignedInViewController: UIViewController {
    @IBOutlet weak var loginStatus: UILabel!
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
    @IBAction func changeEmail(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "changeEmailView") as UIViewController
        self.present(viewController, animated: false, completion: nil)
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        try! Auth.auth().signOut()
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginView") as UIViewController
        self.present(viewController, animated: false, completion: nil)
    }
    @IBAction func changePass(_ sender: Any) {
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "changePassView") as UIViewController
        self.present(viewController, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        loginStatus.text = "You are currently logged in."
        
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
