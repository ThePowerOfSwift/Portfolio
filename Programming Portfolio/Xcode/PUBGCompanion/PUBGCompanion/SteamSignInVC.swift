//
//  SteamSignInVC.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 23/10/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Kanna
import Erik
import Alamofire
import NVActivityIndicatorView

class SteamSignInVC: UIViewController {
    
    @IBOutlet weak var steamUser: UITextField!
    @IBOutlet weak var steamPass: UITextField!
    @IBOutlet weak var steamLoginView: UIView!

    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var loadingViewContainer: UIView!
    var activity: NVActivityIndicatorView!
    var username: String!
    let browser = HBPUBGME.instance
    var isLoggedIn:Bool! = false
    override func viewWillAppear(_ animated: Bool) {
        let url = URL(string: "https://pubg.me/a/steam")!
        browser.visit(url:url) { (obj, err) -> Void in
            if let doc = obj {
                
                if let openID = doc.querySelector("div[class='OpenID_loggedInAccount']"){
                    if let uN = openID.text {
                        print(uN)
                        if let sButton = doc.click("input[id='imageLogin']") {
                            sButton.click()
                            self.isLoggedIn = true
                        }
                        
                        
                        
                    }
                }else {
                    print("NO OPEN ID")
                    self.isLoggedIn = false
                }
            }
        }
    }
    @IBAction func loginPressed(_ sender: Any) {
        if let user = steamUser.text, let pass = steamPass.text {
            if user != "" {
                if pass != "" {
                    browser.currentContent(completionHandler: { (obj, err) in
                        if let doc = obj {
//                            print(doc)
                            if let openID = doc.querySelector("div[class='OpenID_loggedInAccount']"){
                                if let uN = openID.text {
                                    print(uN)
                                    let sendButton = doc.querySelector("input[id='imageLogin']")
                                    sendButton?.click("input[id='imageLogin']")
                                    
                                }
                            } else {
                                let usernameField = doc.querySelector("input[id='steamAccountName']")
                                let passwordField = doc.querySelector("input[id='steamPassword']")
                                usernameField?.set(value: user)
                                passwordField?.set(value: pass)
                                if let sendButton = doc.click("input[id='imageLogin']") {
                                    sendButton.click()
//                                    print(sendButton, usernameField, passwordField)
                                    if let aButton = doc.querySelector("div[class='auth_button leftbtn']") {
//                                        print(aButton,doc.querySelector("div[class='newmodal']"))
                                        DispatchQueue.main.sync {
                                            self.performSegue(withIdentifier: "steamVerify", sender: nil)
                                        }
                                        
                                    }
                                }
                                
                            }
                        }
                        
                    })
                }
            }
        }
    }
    
    
}
