//
//  User.swift
//  KChat
//
//  Created by Kel Robertson on 8/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation

struct User {
    
    private var _username: String
    private var _uid : String
    
    var uid: String {
        return _uid
    }
    
    var username: String {
        return _username
    }
    
    init(uid: String, username: String) {
        _uid = uid
        _username = username
    }
}
