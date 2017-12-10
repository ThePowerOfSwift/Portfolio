//
//  PostCell.swift
//  KellogsSocial
//
//  Created by Kel Robertson on 26/12/2016.
//  Copyright © 2016 Kel Robertson. All rights reserved.
//

import UIKit
import Firebase
class PostCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likesImage: UIImageView!
    
    var likesref: FIRDatabaseReference!
    var post: Post!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        likesImage.addGestureRecognizer(tap)
        likesImage.isUserInteractionEnabled = true
        
    }

    func configureCell(post: Post, image: UIImage? = nil){
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(PostCell.likeTapped(sender:)), name: NSNotification.Name(rawValue: "CustomCellUpdate"), object: nil)
        self.post = post
        likesref = DataService.ds._REF_USER_CURRENT.child("likes").child(post.postKey)
        self.caption.text = post.caption
        self.likeLabel.text = "\(post.likes)"
        if image != nil {
            self.postImage.image = image
        } else {
            let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
            ref.data(withMaxSize: 4 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("KEL: Unable to download image from Firebase Storage - CHECK FILE SIZE")
                } else {
                    print("KEL: Image downloaded from Firebase Storage")
                    if let imageData = data {
                        if let image = UIImage(data: imageData) {
                            self.postImage.image = image
                            FeedVC.imageCache.setObject(image, forKey: post.imageUrl as NSString)
                        }
                    }
                }
            })
        }
        
        
        
        likesref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likesImage.image = UIImage(named: "Like_Lightgrey")
            } else {
                self.likesImage.image = UIImage(named: "Like_Red")
            }
        })
    }
    
    func likeTapped(sender: UITapGestureRecognizer) {
        likesref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likesImage.image = UIImage(named: "Like_Red")
                self.post.adjustLikes(addLike: true)
                self.likesref.setValue(true)
                
                
            } else {
                self.likesImage.image = UIImage(named: "Like_Lightgrey")
                self.post.adjustLikes(addLike: false)
                self.likesref.removeValue()
                
            }
        })
    }
    
}
