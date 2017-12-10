//
//  RegisterVC.swift
//  KChat
//
//  Created by Kel Robertson on 18/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var emailFieldOne: RoundTextField!
    
    @IBOutlet weak var emailFieldTwo: RoundTextField!

    @IBOutlet weak var passwordFieldOne: RoundTextField!
    
    @IBOutlet weak var passwordFieldTwo: RoundTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterVC.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.view.endEditing(true)
    }
    
    @IBAction func registerButtonPressed(_ sender: AnyObject) {
        if let email1 = emailFieldOne.text, let email2 = emailFieldTwo.text, let password1 = passwordFieldOne.text, let password2 = passwordFieldTwo.text, (email1 == email2 && password1 == password2) {
            self.showLoadingView(message: "Registering", disableUI: true)
            self.completeRegister(email: email1, password: password1)
        } else {
            self.NotificationBanner(title: "Email/Passwords Dont Match", message: "Please check spelling and try again,")
        }
    }
    func completeRegister(email:String, password: String) {
        AuthService.instance.createUser(email: email, password: password) { (success, msg, data) in
            if success == true {
                self.hideLoadingViewBasic(animated: true)
                self.NotificationBanner(title: "Sucess!", message: "\(email) has been registered with KChat")
                self.performSegue(withIdentifier: "unwindRegisterVC", sender: nil)
            }
        }
    }
}
