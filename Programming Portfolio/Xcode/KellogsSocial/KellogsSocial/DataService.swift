//
//  DataService.swift
//  KellogsSocial
//
//  Created by Kel Robertson on 27/12/2016.
//  Copyright © 2016 Kel Robertson. All rights reserved.
//

import Foundation
import Firebase
import Swift

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    static let ds = DataService()
    
    //Storage References
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-images")
    
    //DB References
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    
    var REF_POST_IMAGES: FIRStorageReference{
        return _REF_POST_IMAGES
    }
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var _REF_USER_CURRENT: FIRDatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
 
    func createFirebaseDBUser(uid:String, userData: Dictionary<String,String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}
