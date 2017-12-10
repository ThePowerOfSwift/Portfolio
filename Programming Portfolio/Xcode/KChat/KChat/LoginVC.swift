//
//  LoginVC.swift
//  KChat
//
//  Created by Kel Robertson on 7/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailField: RoundTextField!
    
    @IBOutlet weak var passwordField: RoundTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "signIn", sender: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        emailField.text = ""
        passwordField.text = ""
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
        
    }
    
    @IBAction func loginBtnPressed(_ sender: AnyObject) {
        if let email = emailField.text , let pass = passwordField.text , (email.characters.count > 0 && pass.characters.count > 0) {
            showLoadingView(message: "Signing In", disableUI: true)
            AuthService.instance.login(email: email, password: pass, onComplete: { (success, errMsg, data) in
                if errMsg == nil {
                    if success == true {
                        self.hideLoadingViewLogin(success: success!, animated: true)
                        self.performSegue(withIdentifier: "signIn", sender: nil)
                    }
                } else {
                    if success == false {
                        self.NotificationBanner(title: "Error Authenticating", message: errMsg!)
                        self.hideLoadingViewLogin(success: success!, animated: true)
                    }
                }
            })
        } else {
            self.NotificationBanner(title: "Username and Password Required", message: "Please enter both a username and password to sign in.")
        }
    }
    
    @IBAction func registerButtonPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "registerVC", sender: nil)
    }
    
    @IBAction func UnwindToLogin(segue: UIStoryboardSegue) {
    }
}
