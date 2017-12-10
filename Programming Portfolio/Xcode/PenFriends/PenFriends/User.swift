//
//  User.swift
//  PenFriends
//
//  Created by Kel Robertson on 5/02/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation

struct User {
    
    private var _emailAddress: String
    private var _uid : String
    private var _username: String
    
    var uid: String {
        return _uid
    }
    
    var emailAddress: String {
        return _emailAddress
    }
    
    var username: String {
        return _username
    }
    
    init(uid: String, emailAddress: String, username: String) {
        _uid = uid
        _username = username
        _emailAddress = emailAddress
    }
}
