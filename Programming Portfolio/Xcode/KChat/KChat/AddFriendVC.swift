//
//  AddFriendVC.swift
//  KChat
//
//  Created by Kel Robertson on 16/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Firebase
class AddFriendVC: UIViewController {
    
    @IBOutlet weak var emailField: RoundTextField!
    
    private var currentFriend:Bool! = false
    private var requestWaiting:Bool! = false
    private var sendRequest:Bool?
    private var userExists:Bool! = false
    private var user = KeychainWrapper.standard.string(forKey:KEY_UID)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendRequest = false
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddFriendVC.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
    }
    
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        
    }
    @IBAction func sendButtonPressed(_ sender: AnyObject) {
        
        self.showLoadingView(message: "Sending Request", disableUI: false)
        if let email = emailField.text, (email.characters.count > 0){
                self.findEmailAddress(email: email, completion: {
                    if self.userExists == false {
                        DispatchQueue.main.async {
                            self.hideLoadingViewBasic(animated: true)
                            self.NotificationBanner(title: "No User Exists", message: "There is no user by that email address")
                        }
                        
                    } else {
                        DispatchQueue.main.async {
                            self.checkCurrentFriends(email: email)
                        }
                        
                    }
                })
       
            
        } else {
            self.hideLoadingViewBasic(animated: true)
            self.NotificationBanner(title: "Enter Email Address", message: "Enter a friends email address")
        }
        
    }
    
    func alreadyFriends(email:String) {
        self.hideLoadingViewBasic(animated: true)
        self.NotificationBanner(title: "Already Friends", message: "You are already Friends")
    }
    
    func requestWaiting(email:String) {
        self.hideLoadingViewBasic(animated: true)
        self.NotificationBanner(title: "Request Already Sent", message: "There is currently a request pending")
    }
    
    func checkCurrentFriends(email:String) {
        
        DispatchQueue.global(qos: .background).async {
            let emailSearch = FIRDatabase.database().reference(withPath: "users").queryOrdered(byChild: "profile/username").queryEqual(toValue: email)
            emailSearch.observe(.childAdded, with: { (snapshot:FIRDataSnapshot) in
                if snapshot.exists() {
                    
                    if let userDict = snapshot.value as? Dictionary<String,AnyObject> {
                        if snapshot.key != self.user! {
                            userLoop:  for (k,v) in userDict {
                                if k == "friends" {
                                    if let friendsList = v as? Dictionary<String,AnyObject> {
                                        if Array(friendsList.keys).contains(self.user!) {
                                            self.currentFriend = true
                                            print("EXISTS")
                                        }
                                        
                                    }
                                } else if k == "requestedFriends" {
                                    if let requestedFriends = v as? Dictionary<String,String> {
                                        if Array(requestedFriends.keys).contains(snapshot.key) {
                                            self.requestWaiting = true
                                            print("EXISTS")
                                        }
                                        
                                    }
                                } else if k == "friendRequests" {
                                    if let friendRequests = v as? Dictionary<String,AnyObject> {
                                        if Array(friendRequests.keys).contains(self.user!) {
                                            self.requestWaiting = true
                                            print("EXISTS")
                                        }
                                    }
                                }
                                DispatchQueue.main.async {
                                    if self.currentFriend == true {
                                        self.alreadyFriends(email: email)
                                    } else if self.requestWaiting == true {
                                        self.requestWaiting(email: email)
                                    } else {
                                        self.sendRequest = true
                                        self.sendFriendRequest(email: email, uid: snapshot.key)
                                    }
                                }
                                
                                //
                            }
                        } else {
                            self.hideLoadingViewBasic(animated: true)
                            self.NotificationBanner(title: "Cannot Add Yourself", message: "You cannot add yourself as a friend")
                        }
                    }
                }
            })
        }

    }

    func findEmailAddress(email: String, completion: @escaping () -> Void ) {
        DispatchQueue.global(qos: .background).async {
            
            let findEmail = FIRDatabase.database().reference(withPath: "users")
            findEmail.observeSingleEvent(of: .value, with: {(snapshot:FIRDataSnapshot) in
                if let user = snapshot.value as? Dictionary<String,Dictionary<String,AnyObject>> {
                    forloop: for (_, value) in user {
                        switch value["profile"]?["username"] as! String {
                        case email:
                            self.userExists = true
                        default:
                            break
                        }
                       
                    }
                    completion()
                }
            })
            
        }
        
    }
    
    
    func sendFriendRequest(email: String, uid:String) {
        DispatchQueue.global(qos: .background).async {
            
            DataService.instance.REF_USERS.child(self.user!).child("requestedFriends").child(uid).setValue("true")
            DataService.instance.REF_USERS.child(uid).child("friendRequests").child(self.user!).setValue("true")
            DispatchQueue.main.async {
                
                self.hideLoadingViewBasic(animated: true)
                self.dismiss(animated: true)
                self.NotificationBanner(title: "A request has been sent to:", message: email)
            }
            
            
        }
    }
}
