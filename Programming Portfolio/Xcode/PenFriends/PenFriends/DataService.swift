//
//  DataService.swift
//  PenFriends
//
//  Created by Kel Robertson on 5/02/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation
import FirebaseDatabase

let DB_BASE = FIRDatabase.database().reference()

class DataService {
    
    private var _REF_USERS = DB_BASE.child("users")
    
    private static let _instance = DataService()
    
    static var instance: DataService{
        return _instance
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    
    func saveUser(uid: String, userData: Dictionary<String,String> ) {
        REF_USERS.child(uid).child("profile").setValue(userData)
    }
}
