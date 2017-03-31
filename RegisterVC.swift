//
//  RegisterVC.swift
//  PROP
//
//  Created by Conder Shou on 3/31/17.
//  Copyright © 2017 ADI Labs. All rights reserved.
//

import UIKit
import FirebaseAuth
import MBProgressHUD

class RegisterVC: UIViewController {

    var userProfileManager = UserProfileManager.shared

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirmEmail: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    @IBOutlet weak var firstNameError: UILabel!
    @IBOutlet weak var lastNameError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var confirmEmailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var confirmPasswordError: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func validateFields() -> Bool {
        var result = true
        
        if self.firstName.text?.characters.count == 0 {
            self.firstNameError.isHidden = false
            result = false
        }
        else {
            self.firstNameError.isHidden = true
        }
        
        if self.lastName.text?.characters.count == 0 {
            self.lastNameError.isHidden = false
            result = false
        }
        else {
            self.lastNameError.isHidden = true
        }
        
        if (self.email.text?.characters.count ?? 0) < 4 {
            self.emailError.isHidden = false
            result = false
        }
        else {
            self.emailError.isHidden = true
        }
        
        if (self.confirmEmail.text != self.email.text) {
            self.confirmPasswordError.isHidden = false
            result = false
        }
        else {
            self.confirmPasswordError.isHidden = true
        }
        
        if (self.password.text?.characters.count ?? 0) < 6 {
            self.passwordError.isHidden = false
            result = false
        }
        else {
            self.passwordError.isHidden = true
        }
        
        if self.confirmPassword.text != self.password.text {
            self.confirmPasswordError.isHidden = false
            result = false
        }
        else {
            self.confirmPasswordError.isHidden = true
        }
        
        return result
    }
    
    @IBAction func createAccPressed(_ sender: Any) {
        guard self.validateFields() else {
            return
        }
        
        guard let firstName = self.firstName.text else { return }
        guard let lastName = self.lastName.text else { return }
        guard let email = self.email.text else { return }
        guard let password = self.password.text else { return }
            
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            if let `user` = user {
                
                self.userProfileManager.update(for: user, firstName: firstName, lastName: lastName)
                self.performSegue(withIdentifier: "dismissSegue", sender: nil)
            }
            else {
                if let `error` = error {
                    let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: error.localizedDescription, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
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
