//
//  Moment.swift
//  KChat
//
//  Created by Kel Robertson on 9/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation
import UIKit

struct Moment {
    
    private var dateCreated: String!
    private var caption: String!
    private var previewImage: String!
    private var momentType: String!
    private var sentBy: String!
    
    
    var _sentBy: String {
        return sentBy
    }
    var _dateCreated: String {
        return dateCreated
    }
    var _caption: String {
        return caption
    }
    var _previewImage: String {
        return previewImage
    }
    var _momentType: String {
        return momentType
    }
    
    init(caption:String, dateCreated:String, previewImage:String, sentBy: String) {
        self.caption = caption
        self.dateCreated = dateCreated
        self.previewImage = previewImage
        self.sentBy = sentBy
    }
    
    init(momentData: Dictionary<String,AnyObject>) {
        if let dateCreated = momentData["dateCreated"] as? String {
            self.dateCreated = dateCreated
        }
        if let caption = momentData["caption"] as? String {
            self.caption = caption
        }
        if let previewImage = momentData["mediaURL"] as? String {
           self.previewImage = previewImage
        }
        if let sentBy = momentData["userID"] as? String {
            self.sentBy = sentBy
        }
        if let momentType = momentData["mediaType"] as? String {
            self.momentType = momentType
        }
    }
    
}
