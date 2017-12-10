//
//  SendFriendVC.swift
//  KChat
//
//  Created by Kel Robertson on 8/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class SendFriendsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var selectFriendsTableView: UITableView!
    @IBOutlet weak var captionField: RoundTextField!
    
    @IBOutlet weak var sendButton: RoundButton!
    
    @IBOutlet weak var cancelButton: RoundButton!
    
    private var users = [User]()
    private var selectedUsers = Dictionary<String,User>()
    
    private var _snapData: Data?
    private var _Date: String!
    private var _videoURL: URL?
    
    var snapData: Data? {
        set {
            _snapData = newValue
        } get {
            return _snapData
        }
    }
    
    var videoURL: URL? {
        set {
            _videoURL = newValue
        } get {
            return _videoURL
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.sendButton.isEnabled = false
        self.sendButton.setTitle("", for: .disabled)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectFriendsTableView.delegate = self
        selectFriendsTableView.dataSource = self
        selectFriendsTableView.allowsMultipleSelection = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SendFriendsVC.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        
        let user = KeychainWrapper.standard.string(forKey:KEY_UID)
        
        DispatchQueue.global(qos: .background).async {
            DataService.instance.REF_USERS.child(user!).child("friends").observeSingleEvent(of: .value) { (snapshotFriend:FIRDataSnapshot) in
                if snapshotFriend.exists() {
                    self.sendButton.isEnabled = true
                    self.sendButton.setTitle("Send", for: .normal)
                    if let friends = snapshotFriend.value as? Dictionary<String, AnyObject> {
                        for (key, _) in friends {
                            DataService.instance.REF_USERS.child(key).child("profile").child("username").observeSingleEvent(of: .value, with: { (snapshotUser) in
                                
                                let user = User(uid: key, username: snapshotUser.value as! String)
                                self.users.append(user)
                                DispatchQueue.main.async {
                                    self.selectFriendsTableView.reloadData()
                                }
                                
                            })
                        }
                        
                    }
                } else {
                    self.NotificationBanner(title: "Invalid", message: "There are no friends to send to, please cancel and add a friend first")
                    
                    self.sendButton.isEnabled = false
                }
                
            }
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = selectFriendsTableView.dequeueReusableCell(withIdentifier: "selectFriendCell") as! FriendCell
        let user = users[indexPath.row]
        cell.updateUI(user:user)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = selectFriendsTableView.cellForRow(at: indexPath) as! FriendCell
        cell.setCheckmark(selected: true)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = user
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = selectFriendsTableView.cellForRow(at: indexPath) as! FriendCell
        cell.setCheckmark(selected: false)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = nil
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func sendBtnPressed(_ sender: AnyObject) {
        
        self.showLoadingView(message: "Sending Moment", disableUI: true)
        
        let stringFromDate = Date().iso8601    // "2016-06-18T05:18:27.935Z"
        if let dateFromString = stringFromDate.dateFromISO8601 {
            _Date = dateFromString.iso8601     // "2016-06-18T05:18:27.935Z"
        }
        
        if let caption = captionField.text, (caption.characters.count > 0){
            
            if let url = _videoURL {
            let videoName = "\(NSUUID().uuidString)\(url)"
            let ref = StorageService.instance.REF_VIDEO_STORAGE.child(videoName)
            _ = ref.putFile(url, metadata: nil, completion: { (meta:FIRStorageMetadata?, err:Error?) in
                
                if err != nil {
                    print("Error uploading video: \(err?.localizedDescription)")
                } else {
                    let downloadURL = meta!.downloadURL()
                    DataService.instance.sendMoment(senderUID: FIRAuth.auth()!.currentUser!.uid, sendingTo: self.selectedUsers as Dictionary<String, AnyObject>, mediaURL: downloadURL!, textSnippet: "Video", dateCreated: self._Date, mediaType: "Video", caption: self.captionField.text!)
                }
                self.hideLoadingViewBasic(animated: true)
                self.dismiss(animated: true)
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil);
                
            })
            
            } else if let snap = _snapData {
            let ref = StorageService.instance.REF_IMAGE_STORAGE.child("\(NSUUID().uuidString).jpg")
            
            _ = ref.put(snap, metadata: nil, completion: { (meta:FIRStorageMetadata?, err:Error?) in
                if err != nil {
                    print("Error uploading snapshot: \(err?.localizedDescription)")
                } else {
                    let downloadURL = meta!.downloadURL()
                    DataService.instance.sendMoment(senderUID: FIRAuth.auth()!.currentUser!.uid, sendingTo: self.selectedUsers as Dictionary<String, AnyObject>, mediaURL: downloadURL!, textSnippet: "Image", dateCreated: self._Date, mediaType: "Photo", caption: self.captionField.text!)
                    
                }
                self.hideLoadingViewBasic(animated: true)
                self.dismiss(animated: true)
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil);
            })
                
            }
        } else {
            let alert = UIAlertController(title: "Caption Required", message: "You must enter a caption for your moment.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func cancelBtnPressed(_ sender: AnyObject) {
        snapData = nil
        videoURL = nil
        self.dismiss(animated: true)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil);

    }
    
    
}

extension Date {
    static let iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
    var iso8601: String {
        return Date.iso8601Formatter.string(from: self)
    }
}

extension String {
    var dateFromISO8601: Date? {
        return Date.iso8601Formatter.date(from: self)
    }
}
