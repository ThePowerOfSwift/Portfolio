//
//  Post.swift
//  KellogsSocial
//
//  Created by Kel Robertson on 28/12/2016.
//  Copyright © 2016 Kel Robertson. All rights reserved.
//

import Foundation
import Firebase

class Post {
    
    private var _imageUrl: String!
    private var _caption: String!
    private var _likes: Int!
    private var _postKey: String!
    private var _date: NSDate!
    private var  _postRef: FIRDatabaseReference!
    
    
    var date: NSDate {
        return _date
    }
    
    var imageUrl: String {
        return _imageUrl
    }
    var caption: String {
        return _caption
    }
    
    var postKey: String {
        return _postKey
    }
    var likes: Int {
        return _likes
    }
    
    init(caption: String, imageUrl: String, likes: Int, date: NSDate){
        self._date = date
        self._caption = caption
        self._imageUrl = imageUrl
        self._likes = likes
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>){
        self._postKey = postKey
        
        if let date = postData["date"] as? NSDate {
            self._date = date
        }
        if let caption = postData["caption"] as? String{
            self._caption = caption
        }
        if let imageUrl = postData["imageUrl"] as? String{
            self._imageUrl = imageUrl
        }
        if let likes = postData["likes"] as? Int{
            self._likes = likes
        }
        _postRef = DataService.ds.REF_POSTS.child(_postKey)
    }
    
    func adjustLikes(addLike:Bool) {
        if addLike {
            _likes = _likes + 1
        } else {
            _likes = likes - 1
        }
        _postRef.child("likes").setValue(_likes)

    }
}
