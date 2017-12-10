//
//  PlayerInfo.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 4/11/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import AlamofireImage
class PlayerInfo {
    
    fileprivate var _PlayerName: String!
    fileprivate var _Avatar: String!
    fileprivate var _pImage: UIImage! = UIImage()
    fileprivate var _CurrentSeason: String!
    fileprivate var _TimePlayed: Int!
    fileprivate var _lastUpdated: String!
    fileprivate var _OAKills: String!
    fileprivate var _OAMatchesPlayed: String!
    fileprivate var _OAWins: String!
    fileprivate var _OATop10: String!
    fileprivate var _OAKD: String!
    fileprivate var _OAHeals: String!
    
    var playerName: String {
        return _PlayerName
    }
    var avatar: String {
        return _Avatar
        
    }
    var pImage: UIImage {
        return _pImage
    }
    var currentSeason: String {
        return _CurrentSeason
        
    }
    var timePlayed: Int {
        return _TimePlayed
        
    }
    var lastUpdated: String {
        return _lastUpdated
        
    }
    var OAKills: String{
        return _OAKills
    }
    var OAMatchesPlayed: String {
        return _OAMatchesPlayed
    }
    var OAWins: String {
        return _OAWins
    }
    var OATop10: String {
        return _OATop10
    }
    var OAKD: String {
        return _OAKD
    }
    var OAHeals : String {
        return _OAHeals
    }
    
    init(pInfo: [String:JSON], completed: @escaping Comp) {
        self._PlayerName = pInfo["PlayerName"]?.stringValue
        self._Avatar = pInfo["Avatar"]?.stringValue
        self._CurrentSeason = pInfo["defaultSeason"]?.stringValue
        self._TimePlayed = pInfo["TimePlayed"]?.intValue
        if let LU = pInfo["LastUpdated"]?.stringValue {
            let LUpdated = PUBGTRACKER.instance.ReturnDateUpdated(date: LU)
            self._lastUpdated = LUpdated
        }
        
        self._OAMatchesPlayed = pInfo["LifeTimeStats"]![0]["Value"].stringValue
        self._OAWins = pInfo["LifeTimeStats"]![1]["Value"].stringValue
        self._OATop10 = pInfo["LifeTimeStats"]![2]["Value"].stringValue
        self._OAKills = pInfo["LifeTimeStats"]![3]["Value"].stringValue
        self._OAKD = pInfo["LifeTimeStats"]![4]["Value"].stringValue
        self._OAHeals = pInfo["LifeTimeStats"]![5]["Value"].stringValue
        
        Alamofire.request(self._Avatar).responseImage { (response) in
            self._pImage = response.result.value
            completed(true,"")
        }
        
    }
    func resetValues() {
        self._PlayerName = ""
        self._Avatar = ""
        self._CurrentSeason = ""
        self._TimePlayed = 0
        self._lastUpdated = ""
        
        
        self._OAMatchesPlayed = ""
        self._OAWins = ""
        self._OATop10 = ""
        self._OAKills = ""
        self._OAKD = ""
        self._OAHeals = ""
        self._pImage = nil
    }
}
