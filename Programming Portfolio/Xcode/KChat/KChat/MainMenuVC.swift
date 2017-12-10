//
//  MainMenuVC.swift
//  KChat
//
//  Created by Kel Robertson on 13/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainMenuVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    private var menuItemNames = ["Send Moment","Friends","Recieved","Sent", "Profile"]
    
    private var recievedMoments = [Moment]()
    private var sentMoments = [Moment]()
    
    private var recievedCount: Int!
    private var sentCount: Int!
    private var friendCount: Int!
    private var requestedFriendCount: Int!
    private var friendRequestCount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? MenuCell {
            
            let img = UIImage(named: "\(indexPath.row)")
            let newImg = img?.maskWithColor(color: UIColor.white)
            let name = menuItemNames[indexPath.row]
            cell.configureCell(itemName: name, image: newImg!)
            
            return cell
        }
        return MenuCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "sendMoment", sender: nil)
        } else if indexPath.row == 1 {
            self.showLoadingView(message: "Loading", disableUI:true)
            self.observeFriendCount(onComplete: { (success, _, _) in
                if success == true {
                    self.observeRequestedFriendCount(onComplete: { (success, _, _) in
                        if success == true {
                            self.observeFriendRequestCount(onComplete: { (success, _, _) in
                                if success == true {
                                    self.hideLoadingViewBasic(animated: true)
                                    self.performSegue(withIdentifier: "friends", sender: nil)
                                }
                            })
                        }
                    })
                    
                    
                }
            })
        } else if indexPath.row == 2 {
            self.showLoadingView(message: "Loading", disableUI: false)
            self.observeRecievedMessageCount(onComplete: { (success, _, _) in
                if success == true {
                    self.hideLoadingViewBasic(animated: true)
                    self.performSegue(withIdentifier: "recievedMoments", sender: nil)
                }
            })
            
        } else if indexPath.row == 3 {
            self.showLoadingView(message: "Loading", disableUI: false)
            self.observeSentMessageCount(onComplete: { (success, _, _) in
                if success == true {
                    self.hideLoadingViewBasic(animated: true)
                    self.performSegue(withIdentifier: "sentMoments", sender: nil)
                }
            })
            
            
        } else if indexPath.row == 4 {
            performSegue(withIdentifier: "profileSettings", sender: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItemNames.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sentMoments" {
            if let destination = segue.destination as? SentMomentsVC {
                if let sCount = sentCount {
                    destination.sentCount = sCount
                }
                
                destination.moments = sentMoments
            }
        } else if segue.identifier == "recievedMoments" {
            if let destination = segue.destination as? RecievedMomentsVC {
                if let recCount = recievedCount {
                    destination.recievedCount = recCount
                }
                destination.moments = recievedMoments
            }
        } else if segue.identifier == "friends" {
            if let destination = segue.destination as? FriendsVC {
                if let fCount = friendCount {
                    destination.friendCount = fCount
                }
                if let rfCount = requestedFriendCount {
                    if let frCount = friendRequestCount {
                        destination.requestCount = rfCount + frCount
                    }
                }
            }
        }
    }
    
    func observeSentMessageCount(onComplete: Completion?) {
        let user = KeychainWrapper.standard.string(forKey:KEY_UID)
        if let usr = user {
            let momentRef = DataService.instance.REF_USERS.child(usr).child("moments")
            momentRef.observeSingleEvent(of:.value, with: { (snapshot) -> Void in
                if snapshot.exists() {
                    self.sentCount = Int(snapshot.childrenCount)
                    onComplete!(true,nil,nil)
                } else {
                    self.sentCount = 0
                    onComplete!(true,nil,nil)
                }
            })
        }
        
        
    }
    
    func observeRecievedMessageCount(onComplete: Completion?) {
        let user = KeychainWrapper.standard.string(forKey:KEY_UID)
        let momentRef = DataService.instance.REF_USERS.child(user!).child("recievedMoments")
        momentRef.observeSingleEvent(of: .value, with: { (snapshot) -> Void in
            if snapshot.exists() {
                self.recievedCount = Int(snapshot.childrenCount)
                onComplete!(true,nil,nil)
            } else {
                self.recievedCount = 0
                onComplete!(true,nil,nil)
            }
        })
        
    }
    
    func observeFriendCount(onComplete: Completion?) {
        let user = KeychainWrapper.standard.string(forKey:KEY_UID)
        let momentRef = DataService.instance.REF_USERS.child(user!).child("friends")
        momentRef.observeSingleEvent(of: .value, with: { (snapshot) -> Void in
            if snapshot.exists() {
                self.friendCount = Int(snapshot.childrenCount)
                onComplete!(true,nil,nil)
            } else {
                self.friendCount = 0
                onComplete!(true,nil,nil)
            }
        })
    }
    
    func observeFriendRequestCount(onComplete: Completion?) {
        let user = KeychainWrapper.standard.string(forKey:KEY_UID)
        let momentRef = DataService.instance.REF_USERS.child(user!).child("friendRequests")
        momentRef.observeSingleEvent(of: .value, with: { (snapshot) -> Void in
            if snapshot.exists() {
                self.friendRequestCount = Int(snapshot.childrenCount)
                onComplete!(true,nil,nil)
            } else {
                self.friendRequestCount = 0
                onComplete!(true,nil,nil)
            }
        })
    }
    
    func observeRequestedFriendCount(onComplete: Completion?) {
        let user = KeychainWrapper.standard.string(forKey:KEY_UID)
        let momentRef = DataService.instance.REF_USERS.child(user!).child("requestedFriends")
        momentRef.observeSingleEvent(of: .value, with: { (snapshot) -> Void in
            if snapshot.exists() {
                self.requestedFriendCount = Int(snapshot.childrenCount)
                onComplete!(true,nil,nil)
            } else {
                self.requestedFriendCount = 0
                onComplete!(true,nil,nil)
            }
        })
    }
    
    @IBAction func signOutPressed(_ sender: AnyObject) {
        self.showLoadingView(message: "Signing Out", disableUI: true)
        _ = KeychainWrapper.standard.removeObject(forKey:KEY_UID)
        self.sentCount = nil
        self.recievedCount = nil
        try! FIRAuth.auth()?.signOut()
        self.hideLoadingViewBasic(animated: true)
        
        
    }
    @IBAction func UnwindToMenu(segue: UIStoryboardSegue){
        
    }
}
