//
//  FeedVC.swift
//  KellogsSocial
//
//  Created by Kel Robertson on 23/12/2016.
//  Copyright © 2016 Kel Robertson. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    var date: NSDate!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    @IBOutlet weak var addImageButton: UIImageView!
    
    @IBOutlet weak var captionField: CustomField!
    
    var imageSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self

        self.posts = []
        let query = DataService.ds.REF_POSTS.queryOrdered(byChild: "timestamp")
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String,AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.posts = self.posts.reversed()
            self.tableView.reloadData()
            print("KEL:- \(self.posts)")
        })

        DispatchQueue.main.async {
         self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostCell {
            
            if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
                cell.configureCell(post: post, image: img)
            } else {
                cell.configureCell(post: post)
           }
            return cell
        } else {
            return PostCell()
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
          addImageButton.image = image
          imageSelected = true
        } else {
            print("KEL: A Valid image was not selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func postToFirebase(imageURL: String) {
        let date = NSDate()
        let post: Dictionary<String, AnyObject> = [
            "caption": captionField.text! as AnyObject,
            "imageUrl": imageURL as AnyObject,
            "likes": 0 as AnyObject,
            "date": "\(date)" as AnyObject
        ]
        
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        
        captionField.text = ""
        imageSelected = false
        addImageButton.image = UIImage(named:"AddImage")

    
        

        let query = DataService.ds.REF_POSTS.queryOrdered(byChild: "timestamp")
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String,AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.posts = self.posts.reversed()
            self.tableView.reloadData()
        })

    }

    
    @IBAction func postTapped(_ sender: AnyObject) {
        guard let caption = captionField.text, caption != "" else {
            print("KEL: Caption must be entered!")
            return
        }
        guard let image = addImageButton.image, imageSelected == true else {
            print("KEL: An Image must be selected!")
            return
        }
        if let imageData = UIImageJPEGRepresentation(image, 0.2) {
            let imageUID = NSUUID().uuidString
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            
            DataService.ds.REF_POST_IMAGES.child(imageUID).put(imageData, metadata: metaData) {( metaData, error ) in
                if error != nil {
                    print("KEL: Unable to upload image to firebase storage")
                } else {
                    print("KEL: Image successfully uploaded to firebase storage")
                    let downloadURL = metaData?.downloadURL()?.absoluteString
                    if let url = downloadURL {
                        self.postToFirebase(imageURL: url)
                    }
                }
            }
        }
    }
    
    
    @IBAction func addImage(_ sender: AnyObject) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func signOutTapped(_ sender: AnyObject) {
       let keychainResult = KeychainWrapper.standard.removeObject(forKey:KEY_UID)
        print("KEL: \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "signOutSegue", sender: nil)
    }

}
