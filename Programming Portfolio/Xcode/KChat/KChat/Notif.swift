//
//  Notification.swift
//  KChat
//
//  Created by Kel Robertson on 16/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation

struct Notif {
    
    private var _username: String
    
    private var _message: String
    
    private var _uid: String
    
    var uid: String {
        return _uid
    }
    
    var messgae: String {
        return _message
    }
    
    var username: String {
        return _username
    }
    
    init(username: String, message: String, uid: String) {
        _username = username
        _message = message
        _uid = uid
    }
}
