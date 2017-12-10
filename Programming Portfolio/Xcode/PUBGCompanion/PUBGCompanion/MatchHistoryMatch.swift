//
//  MatchHistoryMatch.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 4/11/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation
import SwiftyJSON

class MatchHistoryMatch {
    
    //Match History
    fileprivate var _mHID: String!
    fileprivate var _mHLastUpdated: Double!
    fileprivate var _mHSeason: String!
    fileprivate var _mHSeasonDisplay: String!
    fileprivate var _mHMatchDisplay: String!
    fileprivate var _mHRegionDisplay: String!
    fileprivate var _mHRounds: String!
    fileprivate var _mHWins: String!
    fileprivate var _mHKills: Int!
    fileprivate var _mHAssists: String!
    fileprivate var _mHTop10: String!
    fileprivate var _mHRating: String!
    fileprivate var _mHRatingChange: Double!
    fileprivate var _mHRatingRank: String!
    fileprivate var _mHHeadshots: String!
    fileprivate var _mHKD: String!
    fileprivate var _mHDamage: String!
    fileprivate var _mHTimeSurvived: String!
    fileprivate var _mHWinRating: String!
    fileprivate var _mHWinRank: String!
    fileprivate var _mHKillRating: String!
    fileprivate var _mHKillRank: String!
    fileprivate var _mHMoveDistance: String!
    //Match History
    
    var mhID: String {
        
        return _mHID
        
        
    }
    var mHLastUpdated: Double {
        return _mHLastUpdated
    }
    var mHSeason: String {
        
        return _mHSeason
        
    }
    var mHSeasonDisplay: String {
        
        return _mHSeasonDisplay
        
    }
    var mhMatchDisplay: String {
        
        return _mHMatchDisplay
        
        
    }
    var mhRegionDisplay: String {
        
        return _mHRegionDisplay
        
    }
    var mHRounds: String {
        
        return _mHRounds
        
    }
    var mHWins: String {
        get {
            return _mHWins
        } set  {
            _mHWins = newValue
        }
    }
    var mHKills: Int {
        
        return _mHKills
        
    }
    var mHAssists: String {
        
        return _mHAssists
        
    }
    var mHTop10: String {
        
        return _mHTop10
        
    }
    var mHRating: String {
        
        return _mHRating
        
        
    }
    var mHRatingChange: Double {
        return _mHRatingChange
    }
    var mHRatingRank: String {
        
        return _mHRatingRank
        
    }
    var mHHeadshots: String {
        
        return _mHHeadshots
        
    }
    var mHKD: String {
        
        return _mHKD
        
        
    }
    var mHDamage: String {
        
        return _mHDamage
        
    }
    var mHTimeSurvived: String {
        
        return _mHTimeSurvived
        
    }
    var mHWinRating: String {
        
        return _mHWinRating
        
        
    }
    var mHWinRank: String {
        
        return _mHWinRank
        
    }
    var mHKillRating: String {
        
        return _mHKillRating
        
    }
    var mHKillRank: String {
        
        return _mHKillRank
        
    }
    var mHMoveDistance: String {
        
        return _mHMoveDistance
        
    }
    
    init(match: JSON) {
        let matchH = match.dictionaryValue
        self._mHID = matchH["Id"]?.stringValue
        self._mHLastUpdated = matchH["UpdatedJS"]?.doubleValue
        self._mHSeason = matchH["Season"]?.stringValue
        self._mHSeasonDisplay = matchH["SeasonDisplay"]?.stringValue
        self._mHMatchDisplay = matchH["MatchDisplay"]?.stringValue
        self._mHRegionDisplay = PUBGTRACKER.instance.RegionReturn(region: (matchH["Region"]?.stringValue)!)
        self._mHRounds = matchH["Rounds"]?.stringValue
        self._mHWins = matchH["Wins"]?.stringValue
        self._mHKills = matchH["Kills"]?.intValue
        self._mHAssists = matchH["Assists"]?.stringValue
        self._mHTop10 = matchH["Top10"]?.stringValue
        self._mHRating = matchH["Rating"]?.stringValue
        self._mHRatingChange = matchH["RatingChange"]?.doubleValue
        self._mHRatingRank = "# \((matchH["RatingRank"]?.stringValue)!)"
        self._mHKD = matchH["Kd"]?.stringValue
        self._mHHeadshots = matchH["Headshots"]?.stringValue
        self._mHDamage = matchH["Damage"]?.stringValue
        self._mHTimeSurvived = stringFromTimeInterval(interval:TimeInterval( (matchH["TimeSurvived"]?.doubleValue)!)) as String!
        self._mHWinRating = matchH["WinRating"]?.stringValue
        self._mHWinRank = "# \((matchH["WinRank"]?.stringValue)!)"
        self._mHKillRating = matchH["KillRating"]?.stringValue
        self._mHKillRank = "# \((matchH["KillRank"]?.stringValue)!)"
        self._mHMoveDistance = "\(((matchH["MoveDistance"]?.doubleValue)! / 1000).rounded(toPlaces: 2))Km"
    }
    func stringFromTimeInterval(interval: TimeInterval) -> NSString {
        let ti = NSInteger(interval)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        return NSString(format: "%0.2dh,%0.2dm,%0.2ds",hours,minutes,seconds)
    }
}
