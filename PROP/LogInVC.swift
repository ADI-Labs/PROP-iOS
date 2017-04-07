//
//  LogInVC.swift
//  PROP
//
//  Created by Conder Shou on 3/31/17.
//  Copyright © 2017 ADI Labs. All rights reserved.
//

import UIKit
import FirebaseAuth
import MBProgressHUD


class LogInVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
        
        private func reset() {
            self.emailTextField?.text = ""
            self.passwordTextField?.text = ""
        }
        
        @IBAction func signInAction(_ sender: UIButton) {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            guard let email = self.emailTextField?.text, let password = self.passwordTextField?.text  else {
                return
            }
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                
                MBProgressHUD.hide(for: self.view, animated: true)
                
                if user != nil {
                    self.reset()
                    self.performSegue(withIdentifier: "toMain", sender: self)
                } else {
                    //Error handling
                }
            })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }


    
    
}
