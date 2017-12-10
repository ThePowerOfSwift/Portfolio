//
//  StorageService.swift
//  KChat
//
//  Created by Kel Robertson on 21/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation
import FirebaseStorage
import AVFoundation
import UIKit

let DB_STORAGE = FIRStorage.storage().reference()

class StorageService {
    private static let _instance = StorageService()
    
    static var instance: StorageService {
        return _instance
    }
    
    var REF_IMAGE_STORAGE: FIRStorageReference {
        return DB_STORAGE.child("images")
    }
    
    var REF_VIDEO_STORAGE: FIRStorageReference {
        return DB_STORAGE.child("videos")
    }
    
    func downloadSentMomentImages(moment:Moment, onComplete: Completion?) {
        if let img = SentMomentsVC.sentImageCache.object(forKey: moment._previewImage as NSString) {
            onComplete!(true,"",img)
        } else {
            let ref = FIRStorage.storage().reference(forURL: moment._previewImage)
            ref.data(withMaxSize: 8 * 1024 * 1024, completion: { (data, error) in
                DispatchQueue.global(qos:.background).async {
                    if error != nil {
                        print("KEL: STROAGE SERVICE: Unable to download image from Firebase Storage - CHECK FILE SIZE")
                    } else {
                        
                        if moment._momentType == "Photo" {
                            if let imageData = data {
                                if let image = UIImage(data: imageData) {
                                    SentMomentsVC.sentImageCache.setObject(image, forKey: moment._previewImage as NSString)
                                    
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            onComplete!(true,"",nil)
                        }
                        
                    }
                }
            })
        }
        
    }
    
    func downloadRecievedMomentImages(moment:Moment, onComplete: Completion?) {
        if let img = RecievedMomentsVC.recievedImageCache.object(forKey: moment._previewImage as NSString) {
            onComplete!(true,"",img)
        } else {
            let ref = FIRStorage.storage().reference(forURL: moment._previewImage)
            ref.data(withMaxSize: 8 * 1024 * 1024, completion: { (data, error) in
                DispatchQueue.global(qos:.background).async {
                    if error != nil {
                        print("KEL: STROAGE SERVICE: Unable to download image from Firebase Storage - CHECK FILE SIZE")
                    } else {
                        
                        if moment._momentType == "Photo" {
                            if let imageData = data {
                                if let image = UIImage(data: imageData) {
                                    RecievedMomentsVC.recievedImageCache.setObject(image, forKey: moment._previewImage as NSString)
                                    
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            onComplete!(true,"",nil)
                        }
                        
                    }
                }
            })
        }
    }
}
