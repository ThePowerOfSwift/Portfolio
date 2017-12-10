//
//  ViewController.swift
//  KellogsSocial
//
//  Created by Kel Robertson on 21/12/2016.
//  Copyright © 2016 Kel Robertson. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: CustomField!
    
    @IBOutlet weak var passwordTextField: CustomField!


    override func viewDidLoad() {
        super.viewDidLoad()
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInVC.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "signInSegue", sender: nil)
        }
        
    }
    
    @IBAction func FBButtonTapper(_ sender: AnyObject) {
        
        //Facebook Authentication
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("KEL: Unable to Authenticate with Facebook - \(error)")
            }else if result?.isCancelled == true {
                print("KEL: User cancelled FB Authentication")
            }else{
                print("KEL: Authenticated with Facebook!")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    //Firebase Authentication
        func firebaseAuth(_ credential: FIRAuthCredential) {
            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                if error != nil {
                    print("KEL: Unable to Authenticate with Firebase - \(error)")
                }else {
                    print("KEL: Firebase Authentication Successful")
                    if let user = user {
                        let userData = ["provider": credential.provider]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                    
                }
        })
        
    }
    
    @IBAction func signInTapped(_ sender: AnyObject) {
        
            
            if let email = usernameTextField.text, let password = passwordTextField.text {
                FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                    if error == nil {
                        print("KEL: EMAIL USER AUTHENTICATED WITH FIREBASE")
                        if let user = user {
                            let userData = ["provider": user.providerID]
                            self.completeSignIn(id: user.uid, userData: userData)
                        }
                    } else {
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                print("KEL: Unable to auth wuth firebase using email")
                                let alertController = UIAlertController(title: "Username/Password Error", message:
                                    "Please enter a username and password to log in.", preferredStyle: UIAlertControllerStyle.alert)
                                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                                
                                self.present(alertController, animated: true, completion: nil)
                            } else {
                                print("Authenticated with Firebase")
                                if let user = user {
                                    let userData = ["provider": user.providerID]
                                    self.completeSignIn(id: user.uid, userData: userData)
                                }
                            }
                        })
                    }
                })
            }
        
    }
    
    func completeSignIn(id: String, userData: Dictionary<String,String>) {
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("KEL: Data saved to Keychain \(keychainResult)")
        
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        
        performSegue(withIdentifier: "signInSegue", sender: nil)
    }
}

