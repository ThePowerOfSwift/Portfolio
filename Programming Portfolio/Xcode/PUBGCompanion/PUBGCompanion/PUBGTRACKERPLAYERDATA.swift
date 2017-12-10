//
//  PUBGOverallData.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 4/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PUBG_TRACKER_PLAYERDATA {
    
//    fileprivate var _Region: String!
//    fileprivate var _Season: String!
//    fileprivate var _MatchType : String!
//    fileprivate var _Rating: String!
//    fileprivate var _WinPercent: String!
//    fileprivate var _Top10Rate: String!
//    fileprivate var _KDRatio: String!
//    fileprivate var _Wins: String!
//    fileprivate var _Top10Count: String!
//    fileprivate var _KillCount: String!
//    fileprivate var _DamageCount: String!
    fileprivate var _PlayerName: String!
    fileprivate var _Avatar: String!
    fileprivate var _CurrentSeason: String!
    fileprivate var _TimePlayed: Int!
    fileprivate var _MatchHistory: [String:JSON]!
    fileprivate var _Stats: [String:JSON]!
    fileprivate var _LifetimeStats: [String:JSON]!
    
//    var region: String {
//        return _Region
//    }
//    var season: String {
//        return _Season
//    }
//    var matchType: String {
//        return _MatchType
//    }
//    var rating: String {
//        return _Rating
//    }
//    var winPercent: String {
//        return _WinPercent
//    }
//    var top10Rate: String {
//        return _Top10Rate
//    }
//    var kdRatio: String {
//        return _KDRatio
//    }
//    var wins: String {
//        return _Wins
//    }
//    var top10Count: String {
//        return _Top10Count
//    }
//    var killCount: String {
//        return _KillCount
//    }
//    var damageCount: String {
//        return _DamageCount
//    }

    var playerName: String {
        return _PlayerName
    }
    var avatar: String {
        return _Avatar
    }
    var currentSeason: String {
        return _CurrentSeason
    }
    var timePlayed: Int {
        return _TimePlayed
    }
    var matchHistory: [String:JSON] {
        return _MatchHistory
    }
    var stats: [String:JSON] {
        return _Stats
    }
    var lifetimeStats: [String:JSON] {
        return _LifetimeStats
    }
    
    
    init(data: [String:JSON]) {
        if let matchH = data["MatchHistory"]?.dictionary {
            _MatchHistory = matchH
        }
        if let stat = data["Stats"]?.dictionary {
            _Stats = stat
        }
        if let lifetime = data["LifeTimeStats"]?.dictionary {
            _LifetimeStats = lifetime
        }
    }
}
