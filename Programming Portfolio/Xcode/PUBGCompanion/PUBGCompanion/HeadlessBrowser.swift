//
//  PUBGTRACKERStats.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 25/10/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation
import Erik
import Alamofire
import Kanna


class HBPUBGME {
    
    fileprivate static let _instance = Erik()
    
    static var instance: Erik {
        return _instance
    }
    
    
    class func Visitpage(){
        let url = URL(string: "https://pubg.me/a/steam")!
        
        HBPUBGME.instance.visit(url: url) { (obj, err) -> Void in
            
        }
    }
 class func CheckLogIn(name: String, completed: @escaping Complete) {
    let url = URL(string: "https://pubg.me/a/steam")!
    
        HBPUBGME.instance.currentContent { (obj, err) -> Void in

            if let doc = obj {

                if let openID = doc.querySelector("div[class='OpenID_loggedInAccount']"){
                    if let uN = openID.text {

                        let sendButton = doc.querySelector("input[id='imageLogin']")
                        sendButton?.click()
                        completed(true, "loggedInandVerified", doc)
                    }
                } else {
                    if let usernameField = doc.querySelector("input[id='steamAccountName']") {

                        UserDefaults.standard.set(false, forKey: "steamLoggedIn")
                        completed(false,"notLoggedIn",doc)
                    }

                }
            } else {

            }

        }
    }
   class func UpdateModal(reg: String,completed: @escaping Complete) {
        HBPUBGME.instance.currentContent  { (obj , error) in

            if let doc = obj {

                if let profileUpdate = doc.querySelector("button[class='btn btn-profile-update']") {
                    profileUpdate.click()
                    HBPUBGME.instance.currentContent { (obj , error) in
                        if let _ = doc.querySelector("div[class='modal-content']") {
                            let region = PUBGME.instance.RegionReturn(region: UserDefaults.standard.string(forKey: "defaultRegion")!)
                            if let checkbox = doc.querySelector("input[value*='\(region)']") {
                                let _ = checkbox.click("input[value*='\(region)']")
                                if let _ = doc.querySelector("button[id='update-profile-submit']") {
                                    completed(true,"readyForUpdate", region)
                                }
                            }
                        }
                    }
                } else {

                    let region = ""
                    completed(false,"tooSoonForUpdate", region)
                }
            }
        }
    }
    
   class func PubgMeUpdate(region: String?, completed: @escaping Complete) {
        if let r = region {
            let url = "https://pubg.me/i/profile-region-update"
            
            let parameters = [
                "region[]:": "\(r)"
            ]
            
            /*
             SUBMITS FORM
             */
            
            Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
                switch response.result {
                case .success:
                    if let value = response.result.value {
                    completed(true, "updateSuccess", value)
                    }
                case .failure(let error):
                    completed(true, "updateFailure", error)
                }
            }
        }
    }
    
   class func SteamSignIn(username:String, password:String, completed: @escaping Complete){
    let url = URL(string: "https://pubg.me/a/steam")!
    HBPUBGME.instance.visit(url:url) { document, error in
            if let e = error {

            } else if let doc = document {
                if let openID = doc.querySelector("div[class='OpenID_loggedInAccount']"){
                    if let uN = openID.text {

                        let sendButton = doc.querySelector("input[id='imageLogin']")
                        sendButton?.click()
                        completed(true, "alreadyVerified", doc)
                    }
                } else {
                    let usernameField = doc.querySelector("input[id='steamAccountName']")
                    let passwordField = doc.querySelector("input[id='steamPassword']")
                    usernameField?.set(value: username)
                    passwordField?.set(value: password)
                    let sendButton = doc.querySelector("input[id='imageLogin']")
                    sendButton?.click()
                    if let _ = doc.querySelector("div[class='auth_button leftbtn']") {
                        
                        completed(false, "needVerification", false)
                    }
                }

            }
        }
    }
   class func SteamVerify(aCode:String, completed: @escaping Complete){
        HBPUBGME.instance.currentContent { (obj, err) -> Void in
            if let error = err {

                completed(false,"error",error)
                // TODO: deal with error
 
            } else if let document = obj {
                
                if let openID = document.querySelector("div[class='OpenID_loggedInAccount']"){
                    if let uN = openID.text {
     
                        let sendButton = document.querySelector("input[id='imageLogin']")
                        sendButton?.click()
                        completed(true, "finishedVerifying", document)
                    }
                } else {
                    let authCode = document.querySelector("input[id='authode']")
                    authCode?.set(value: aCode)
                    let friendName = document.querySelector("input[id='friendlyname']")
                    friendName?.set(value: "PUBGHub")
                    let sendButton = document.querySelector("div[class='auth_button leftbtn']")
                    sendButton?.click()
                    if let contSteam = document.querySelector("a[id='success_continue_btn']") {
                        contSteam.click()
                        CheckLogIn(name: "kellogs", completed: { (s, m, d) in
                   
                        })
                        
                        
                    } else if let tryAgain = document.querySelector("div[class='auth_modal_h1']") {
                        if let pageMessage = document.text {
                            if pageMessage == "Whoops!" {
                                //                            completed(false,"verifiyingFailed",tryAgain)
                            }
                        }
                        
                        //TODO: handle error verify
                    }
                }

            }
        }
    }
}
