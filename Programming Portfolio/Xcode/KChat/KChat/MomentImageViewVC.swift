//
//  MomentImageViewVC.swift
//  KChat
//
//  Created by Kel Robertson on 14/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

class MomentImageViewVC: UIViewController {

    @IBOutlet weak var imageContainer: UIImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    var moment: Moment?
    var momentType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let mom = moment {
            
            if momentType == "sent"{
            
                if let img = SentMomentsVC.sentImageCache.object(forKey: mom._previewImage as NSString) {
                    imageContainer.image = img
                    
            }
                captionLabel.text = mom._caption
            } else if momentType == "recieved" {
                if let img = RecievedMomentsVC.recievedImageCache.object(forKey: mom._previewImage as NSString) {
                    imageContainer.image = img
                    
                }
                captionLabel.text = mom._caption
            }
        }
        
    }

    @IBAction func doneButtonPressd(_ sender: AnyObject) {
        self.dismiss(animated: true) { 
            self.showLoadingView(message: "Loading...", disableUI: false)
        }
    }
    

}
