//
//  ViewController.swift
//  PenFriends
//
//  Created by Kel Robertson on 5/02/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import FirebaseDatabase

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var emailAddressInput: CustomTextField!
    
    @IBOutlet weak var passwordInput: CustomTextField!
    
    @IBOutlet weak var usernameInput: CustomTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }

    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: "uid") {
            performSegue(withIdentifier: "signIn", sender: nil)
        }
    }

    func dismissKeyboard() {
        self.view.endEditing(true)
        
    }
    
    @IBAction func facebookLoginPressed(_ sender: Any) {
    }
    
    @IBAction func googleLoginPressed(_ sender: Any) {
    }

    @IBAction func instagramLoginPressed(_ sender: Any) {
    }
    
    @IBAction func twitterLoginPressed(_ sender: Any) {
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        
        if let username = usernameInput.text, (username.characters.count > 0 ) {
          let usernameSearch = FIRDatabase.database().reference(withPath: "users").queryOrdered(byChild: "profile/username").queryEqual(toValue: username)
            usernameSearch.observe(.value, with: { (snapshot:FIRDataSnapshot) in
                print(snapshot)
                if let user =  snapshot.value as? Dictionary<String,AnyObject> {
                    print(user)
                    //user exists choose different username
                } else {
                    if let email = self.emailAddressInput.text , let pass = self.passwordInput.text , (email.characters.count > 0 && pass.characters.count > 0) {
                        AuthService.instance.login(username: username,email: email, password: pass, onComplete: { (success, errMsg, data) in
                            if errMsg == nil {
                                if success == true {
                                    self.performSegue(withIdentifier: "signIn", sender: nil)
                                    
                                } else {
                                    
                                }
                                
                            } else {
                                
                            }
                        })
                    } else {
                        //Enter details
                    }
                }
            })
            
        
        }
        
        
        
    }
}

