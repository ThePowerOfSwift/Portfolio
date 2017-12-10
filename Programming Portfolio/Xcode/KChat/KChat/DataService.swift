//
//  DataService.swift
//  KChat
//
//  Created by Kel Robertson on 7/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//
import Foundation
import FirebaseDatabase
import Swift

let DB_BASE = FIRDatabase.database().reference()

typealias Completed = (_ suc:Bool?, _ em: String?, _ d: AnyObject?) -> Void
typealias DownloadComplete = (_ suc:Bool?, _ em: String?, _ d: Moment?) -> Void

class DataService {
    
    private static let _instance = DataService()

    static var instance: DataService {
        return _instance
    }
    
    //DB References
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child(KEY_USERS)
    
    //Storage References
    private var _REF_MOMENTS = DB_BASE.child("moments")
    
    var REF_MOMENTS: FIRDatabaseReference{
        return _REF_MOMENTS
    }
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
 
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var _REF_USER_CURRENT: FIRDatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
    
    func saveUser(uid: String, userData: Dictionary<String,String> ) {
        REF_USERS.child(uid).child("profile").setValue(userData)
    }
    
    func sendMoment(senderUID: String, sendingTo:Dictionary<String, AnyObject>, mediaURL: URL, textSnippet: String? = nil, dateCreated:String, mediaType: String, caption: String) {
        
        //Ref moment in Sender structure
        let momentRef = REF_BASE.child("moments").childByAutoId()
        
        let momentID = momentRef.key
        REF_USERS.child(senderUID).child("moments").child(momentID).setValue("true")
        
        var uids = Dictionary<String,AnyObject>()
        for uid in sendingTo.keys {
            uids = [uid:"true" as AnyObject]
            
            REF_USERS.child(uid).child("recievedMoments").child(momentID).setValue("true")
        }

        //Store the moment
        let moment: Dictionary<String, AnyObject> = ["mediaURL":mediaURL.absoluteString as AnyObject, "userID":senderUID as AnyObject,"openCount": 0 as AnyObject, "sharedTo":uids  as AnyObject, "dateCreated": dateCreated as AnyObject, "caption": caption as AnyObject, "mediaType": mediaType as AnyObject]
        
        //Ref Moment in Reciever Structure
        momentRef.setValue(moment)
    }
    
  
    func observeSentMessages(onComplete: DownloadComplete?) {
        let user = KeychainWrapper.standard.string(forKey:KEY_UID)
        let momentRef = DataService.instance.REF_USERS.child(user!).child("moments")
        momentRef.observe(.childAdded, with: { (snapshot) -> Void in
            if snapshot.exists() {
                if snapshot.value != nil {
                   DataService.instance.REF_MOMENTS.child(snapshot.key).observeSingleEvent(of:.value, with: { (momentData) in
                        if momentData.value != nil {
                                if let momentsDict = momentData.value as? Dictionary<String,AnyObject> {
                                    let moment = Moment(momentData: momentsDict)
                                    onComplete!(true,"",moment)
                                }
                            
                        } else {
                            print("No Moments")
                        }
                    })
                    
                }
            } else {
                onComplete!(false,nil,nil)
            }
        })
      
    }
    func observeRecievedMessages(onComplete: DownloadComplete?) {
        let user = KeychainWrapper.standard.string(forKey:KEY_UID)
        let momentRef = DataService.instance.REF_USERS.child(user!).child("recievedMoments")
        momentRef.observe(.childAdded, with: { (snapshot) -> Void in
            if snapshot.exists() {
                if snapshot.value != nil {
                    DataService.instance.REF_MOMENTS.child(snapshot.key).observe(.value, with: { (momentData) in
                        if momentData.value != nil {
                            if let momentsDict = momentData.value as? Dictionary<String,AnyObject> {
                                let moment = Moment(momentData: momentsDict)
                                onComplete!(true,"",moment)
                            }
                        } else {
                            print("No Moments")
                        }
                    })
                }
            } else {
                onComplete!(false,nil,nil)
            }
        })
       
    }
    
}


