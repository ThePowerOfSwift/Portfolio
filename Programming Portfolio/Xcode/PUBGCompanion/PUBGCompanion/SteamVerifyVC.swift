//
//  SteamVerifyVC.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 24/10/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

class SteamVerifyVC: UIViewController {
    
    @IBOutlet weak var steamVerify: UITextField!
    
    let browser = HBPUBGME.instance
    
    override func viewWillAppear(_ animated: Bool) {
//        browser.currentContent(completionHandler: { (obj, err) in
////            print(obj,err)
//        })
    }
    @IBAction func steamVerifyPressed(_ sender: Any) {
        if let aCode = steamVerify.text {
            if aCode != "" {
                browser.currentContent(completionHandler: { (obj, err) in
                    if let error = err {
                        print("ERROR: \(error)")
                        // TODO: deal with error
                        
                    } else if let document = obj {
                        print(document.querySelector("input[id='authcode']") )
                        if let authCode = document.querySelector("input[id='authcode']") {
                            
                            authCode.set(value: aCode)
                            print(authCode.content, aCode)
                            if let friendName = document.querySelector("input[id='friendlyname']") {
                                friendName.set(value: "PUBGHub")
                                print(friendName)
                                if let sendButton = document.click("div[class='auth_button leftbtn']") {
                                    sendButton.click(completionHandler: { (data, err) in
                                        if let contSteam = document.querySelector("a[id='success_continue_btn']") {
                                            contSteam.click(completionHandler: { (data, err) in
                                                if err == nil {
                                                    DispatchQueue.main.async {
                                                        self.performSegue(withIdentifier: "showData", sender: nil)
                                                    }
                                                }
                                            })
                                        
                                            //                            self.performSegue(withIdentifier: "showData", sender: nil)
                                        } else if let tryAgain = document.querySelector("div[class='auth_modal_h1']") {
                                            if let pageMessage = document.text {
                                                if pageMessage == "Whoops!" {
                                                    
                                                }
                                            }
                                        }
                                    })
                                    
                                }
                            }
                        }
                        
                        
                        
                        
                       
                    }
                })
            } else {
                self.performSegue(withIdentifier: "showData", sender: nil)
            }
        }
        
    }
}
