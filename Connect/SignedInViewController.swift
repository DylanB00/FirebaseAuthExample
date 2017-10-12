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
        
        let currentUserEmail = Auth.auth().currentUser?.email

        loginStatus.text = "You are currently logged in.\nEmail: " + currentUserEmail! + "\n:)"
        
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
