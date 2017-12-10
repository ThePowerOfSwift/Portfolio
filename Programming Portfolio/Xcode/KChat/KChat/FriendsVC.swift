//
//  FriendsVC.swift
//  KChat
//
//  Created by Kel Robertson on 8/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Firebase

typealias CompletionHandler = (_ success:Bool) -> Void

class FriendsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NotificationCellDelegate, NotificationRequestCellDelegate {
    
    @IBOutlet weak var friendsTableView: UITableView!
    
    @IBOutlet weak var addFriendButton: UIButton!

    private var users = [User]()
    
    private var friendRequests = [Notif]()
    private var requestedFriends = [Notif]()
    var requestCount:Int!
    var friendCount:Int!
    var count = 0
    
    private var sectionTitles = ["Friend Requests", "My Friends"]
    
    private var user = KeychainWrapper.standard.string(forKey:KEY_UID)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let img = UIImage(named: "6")
        let newImg = img?.maskWithColor(color: UIColor.white)
        
        addFriendButton.setImage(newImg, for: .normal)
        friendsTableView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.showLoadingView(message: "Loading", disableUI: true)
        DispatchQueue.global(qos: .background).async {
            self.friendsTableView.dataSource = self
            
            self.users = []
            self.requestedFriends = []
            self.friendRequests = []
            self.downloadTableData { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.friendsTableView.dataSource = self
                        self.friendsTableView.reloadData()
                        self.hideLoadingViewBasic(animated: true)
                        self.count += 1
                        if self.count == self.friendCount {
                            
                        }
                    }
                    
                }
            }
        }
        
        
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return sectionTitles[0]
        } else if section == 1 {
            return sectionTitles[1]
        }
        return ""
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            if friendRequests.count == 0 {
                
            } else {
                let notification = friendRequests[indexPath.row]
                
                if let cell = friendsTableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as? NotificationCell {
                    cell.notificationCell(notification: notification, indexPath: indexPath as NSIndexPath)
                    cell.delegate = self
                    return cell
                    
                }
            }
            
            if requestedFriends.count == 0 {
                
            } else {
                let notificationRequest = requestedFriends[indexPath.row]
                if let cell = friendsTableView.dequeueReusableCell(withIdentifier: "notificationRequestCell", for: indexPath) as? NotificationRequestCell {
                    cell.notificationCellRequested(notification: notificationRequest, indexPath: indexPath as NSIndexPath)
                    cell.delegate = self
                    return cell
                    
                }
            }
            
            
        } else if indexPath.section == 1 {
            let user = users[indexPath.row]
            if let cell = friendsTableView.dequeueReusableCell(withIdentifier: "myFriendsCell", for: indexPath) as? MyFriendsCell {
                cell.updateUI(user: user)
                return cell
            }
        }
        return UITableViewCell()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return (friendRequests.count + requestedFriends.count)
        } else if section == 1 {
            return users.count
        }
        return 0
    }
    
    func cellAddButtonPressed(cell: NotificationCell, uid: String) {
        let indexPath = self.friendsTableView.indexPathForRow(at: cell.center)!
        DataService.instance.REF_USERS.child(self.user!).child("friends").child(cell.uid).setValue("true")
        DataService.instance.REF_USERS.child(cell.uid).child("friends").child(self.user!).setValue("true")
        DataService.instance.REF_USERS.child(self.user!).child("friendRequests").child(cell.uid).removeValue()
        DataService.instance.REF_USERS.child(cell.uid).child("requestedFriends").child(self.user!).removeValue()
        friendRequests.remove(at: indexPath.row)
        self.friendsTableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .fade)
        self.users = []
        downloadTableData { (success) in
            if success {
              self.friendsTableView.reloadSections(NSIndexSet(index: 1) as IndexSet, with: .fade)
            } else {
                
            }
        }
        
    }
    func cellDenyButtonPressed(cell: NotificationCell, uid: String) {
        let indexPath = self.friendsTableView.indexPathForRow(at: cell.center)!
        friendRequests.remove(at: indexPath.row)
        DataService.instance.REF_USERS.child(uid).child("requestedFriends").child(self.user!).removeValue()
        DataService.instance.REF_USERS.child(self.user!).child("friendRequests").child(uid).removeValue()
        
        self.friendsTableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .fade)
    }
    
    func cellDenyRequestButtonPressed(cell: NotificationRequestCell, uid: String) {
        let indexPath = self.friendsTableView.indexPathForRow(at: cell.center)!
        requestedFriends.remove(at: indexPath.row)
        DataService.instance.REF_USERS.child(uid).child("friendRequests").child(self.user!).removeValue()
        DataService.instance.REF_USERS.child(self.user!).child("requestedFriends").child(uid).removeValue()
        self.friendsTableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .fade)
    }
    
    func downloadTableData(onCompletion: @escaping CompletionHandler) {
        
            
            //Friends List
            DataService.instance.REF_USERS.child(self.user!).child("friends").observeSingleEvent(of: .value) { (snapshotFriend:FIRDataSnapshot) in
                
                if let friends = snapshotFriend.value as? Dictionary<String, AnyObject> {
                    for (key, _) in friends {
                        DataService.instance.REF_USERS.child(key).child("profile").child("username").observeSingleEvent(of: .value, with: { (snapshotUser) in
                            
                            let user = User(uid: key, username: snapshotUser.value as! String)
                            self.users.append(user)
                            
                            onCompletion(true)
                        })
                    }
                    
                }
                
            }
            //Notification Send List
            DataService.instance.REF_USERS.child(self.user!).child("friendRequests").observeSingleEvent(of: .value) { (snapshot:FIRDataSnapshot) in
                if let freindRequest = snapshot.value as? Dictionary<String,AnyObject> {
                    for (key, _) in freindRequest {
                        DataService.instance.REF_USERS.child(key).child("profile").child("username").observeSingleEvent(of:.value, with: {(snapshotUser) in
                            let notifications = Notif(username: snapshotUser.value as! String, message: "Has sent a friend request", uid: key)
                            self.friendRequests.append(notifications)
                            
                            onCompletion(true)
                        })
                        
                    }
                }
                
            }
            //Notification Recieved List
        DataService.instance.REF_USERS.child(self.user!).child("requestedFriends").observeSingleEvent(of: .value) { (snapshot:FIRDataSnapshot) in
                if let requestedFriend = snapshot.value as? Dictionary<String,AnyObject> {
                    for (key, _) in requestedFriend {
                        DataService.instance.REF_USERS.child(key).child("profile").child("username").observeSingleEvent(of:.value, with: {(snapshotUser) in
                            let notifications = Notif(username: "Friend request sent to", message: "\(snapshotUser.value as! String)", uid: key)
                            self.requestedFriends.append(notifications)
                            
                            onCompletion(true)
                        })
                        
                    }
                }
        }
        
    }
    
    @IBAction func addFriendPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "addFriend", sender: nil)
        
    }
    
    @IBAction func UnwindToFriends(segue: UIStoryboardSegue){
        
    }
    
}
