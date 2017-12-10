//
//  Stats.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 4/11/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation
import SwiftyJSON

class Stats {
    
    fileprivate var _Region: String!
    fileprivate var _Season: String!
    fileprivate var _Match: String!
    fileprivate var _individualStats: IndividualStats!
    fileprivate var _iStats = [IndividualStats]()
    
    var Region:String {
        return _Region
    }
    var Season: String {
        return _Season
    }
    var Match: String {
        return _Match
    }
    var individualStats: IndividualStats {
        return _individualStats
    }
    var iStats: [IndividualStats] {
        return _iStats
    }
    
    init(stat: JSON) {
        let stats = stat.dictionaryValue
        self._Match = stats["Match"]?.stringValue
        self._Season = stats["Season"]?.stringValue
        self._Region = stats["Region"]?.stringValue
        if let istat = stats["Stats"]?.arrayValue {
            self._individualStats = IndividualStats(master: self, iStats: istat)

        }
    }
    
    class IndividualStats {
        unowned let parent: Stats
        
        fileprivate var _KDRatio: String!
        fileprivate var _WinPercent: String!
        fileprivate var _TimeSurvived: String!
        fileprivate var _RoundsPlayed: String!
        fileprivate var _Wins: Int!
        fileprivate var _WinTop10Ratio: String!
        fileprivate var _Tope10s: String!
        fileprivate var _Top10Ratio: String!
        fileprivate var _Losses: String!
        fileprivate var _Rating: String!
        fileprivate var _Rank: String!
        fileprivate var _BestRating: String!
        fileprivate var _BestRank: String!
        fileprivate var _AvgDmgPerMatch: String!
        fileprivate var _HeadshotKillsPG: String!
        fileprivate var _HealsPG: String!
        fileprivate var _KillsPG: String!
        fileprivate var _MoveDistancePG: String!
        fileprivate var _RevivesPG: String!
        fileprivate var _RoadKillsPG: String!
        fileprivate var _TeamKillsPG: String!
        fileprivate var _TimeSurvivedPG: String!
        fileprivate var _Top10sPG: String!
        fileprivate var _Kills: Int!
        fileprivate var _Assists: String!
        fileprivate var _Suicides: String!
        fileprivate var _TeamKills: String!
        fileprivate var _HeadshotKills: String!
        fileprivate var _HeadshotKillRatio: String!
        fileprivate var _VehiclesDestroyed: String!
        fileprivate var _RoadKills: String!
        fileprivate var _DailyKills: String!
        fileprivate var _WeeklyKills: String!
        fileprivate var _RoundMostKills: String!
        fileprivate var _MaxKillStreak: String!
        fileprivate var _WeaponsAquired: String!
        fileprivate var _DaysSurvived: String!
        fileprivate var _LongestTimeSurvived: String!
        fileprivate var _MostSurvivalTime: String!
        fileprivate var _AvgSurvivalTime: String!
        fileprivate var _WinPoints: String!
        fileprivate var _WalkDistance: String!
        fileprivate var _RideDistance: String!
        fileprivate var _MoveDistance: String!
        fileprivate var _AvgWalkDistance: String!
        fileprivate var _AvgRideDistance: String!
        fileprivate var _LongestKill: String!
        fileprivate var _Heals: String!
        fileprivate var _Revives: String!
        fileprivate var _Boosts: String!
        fileprivate var _DamageDelt: String!
        fileprivate var _DBNO: String!
        fileprivate var _KDA: String!
        fileprivate var _LK: Double!
        fileprivate var _H: Int!
        fileprivate var _TA: Double!
        
        var H: Int {
            return _H
        }
        
        var TA: Double {
            return _TA
        }
        
        var LK: Double {
            return _LK
        }
        
        var KDRatio: String {
            return _KDRatio
        }
        var WinPercent: String {
            return _WinPercent
        }
        var TimeSurvived: String {
            return _TimeSurvived
        }
        var RoundsPlayed: String {
            return _RoundsPlayed
        }
        var Wins: Int {
            return _Wins
        }
        var WinTop10Ratio: String {
            return _WinTop10Ratio
        }
        var Top10s: String {
            return _Tope10s
        }
        var Top10Ratio: String {
            return _Top10Ratio
        }
        var Losses: String {
            return _Losses
        }
        var Rating: String {
            return _Rating
        }
        var Rank: String {
            return _Rank
        }
        var BestRating:String {
            return _BestRating
        }
        var BestRank: String {
            return _BestRank
        }
        var AvgDmgPerMatch: String {
            return _AvgDmgPerMatch
        }
        var HeadshotKillsPG: String {
            return _HeadshotKillsPG
        }
        var HealsPG: String {
            return _HealsPG
        }
        var KillsPG: String {
            return _KillsPG
        }
        var MoveDistancePG: String {
            return _MoveDistancePG
        }
        var RevivesPG: String {
            return _RevivesPG
        }
        var RoadKillsPG: String {
            return _RoadKillsPG
        }
        var TeamKillsPG: String {
            return _TeamKillsPG
        }
        var TimeSurvivedPG: String {
            return _TimeSurvivedPG
        }
        var Top10sPG: String {
            return _Top10sPG
        }
        var Kills: Int {
            return _Kills
        }
        var Assists: String {
            return _Assists
        }
        var Suicides: String {
            return _Suicides
        }
        var TeamKills: String {
            return _TeamKills
        }
        var HeadshotsKills: String {
            return _HeadshotKills
        }
        var HeadshotKillRatio: String {
            return _HeadshotKillRatio
        }
        var VehiclesDestroyed: String {
            return _VehiclesDestroyed
        }
        var RoadKills: String {
            return _RoadKills
        }
        var DailyKills: String {
            return _DailyKills
        }
        var WeeklyKills: String {
            return _WeeklyKills
        }
        var RoundMostKills: String {
            return _RoundMostKills
        }
        var MaxKillStreak: String {
            return _MaxKillStreak
        }
        var WeaponsAquired: String {
            return _WeaponsAquired
        }
        var DaysSurvived: String {
            return _DaysSurvived
        }
        var LongestTimeSurvuved: String {
            return _LongestTimeSurvived
        }
        var MostSurvivalTime: String {
            return _MostSurvivalTime
        }
        var AvgSurvivalTime: String {
            return _AvgSurvivalTime
        }
        var WinPoints: String {
            return _WinPoints
        }
        var WalkDistance: String {
            return _WalkDistance
        }
        var RideDistance: String {
            return _RideDistance
        }
        var MoveDistance: String {
            return _MoveDistance
        }
        var AvgWalkDistance: String {
            return _AvgWalkDistance
        }
        var AvgRideDistance: String {
            return _AvgRideDistance
        }
        var LongestKill: String {
            return _LongestKill
        }
        var Heals: String {
            return _Heals
        }
        var Revives: String {
            return _Revives
        }
        var Boosts: String {
            return _Boosts
        }
        var DamageDelt: String {
            return _DamageDelt
        }
        var DBNO: String {
            return _DBNO
        }
        var KDA: String {
            return _KDA
        }
        
        init(master: Stats, iStats: [JSON]) {
            self.parent = master
            self._KDRatio = iStats[0]["displayValue"].stringValue
            self._WinPercent = iStats[1]["displayValue"].stringValue
            self._TimeSurvived = iStats[2]["displayValue"].stringValue
            self._RoundsPlayed = iStats[3]["displayValue"].stringValue
            self._Wins = iStats[4]["displayValue"].intValue
            self._WinTop10Ratio = iStats[5]["displayValue"].stringValue
            self._Tope10s = iStats[6]["displayValue"].stringValue
            self._Top10Ratio = iStats[7]["displayValue"].stringValue
            self._Losses = iStats[8]["displayValue"].stringValue
            self._Rating = iStats[9]["displayValue"].stringValue
            self._Rank = iStats[9]["rank"].stringValue
            self._BestRating = iStats[10]["displayValue"].stringValue
            self._BestRank = iStats[11]["displayValue"].stringValue
            self._AvgDmgPerMatch = iStats[12]["displayValue"].stringValue
            self._HeadshotKillsPG = iStats[13]["displayValue"].stringValue
            self._HealsPG = iStats[14]["displayValue"].stringValue
            self._KillsPG = "4000"
            self._MoveDistancePG = iStats[16]["displayValue"].stringValue
            self._RevivesPG = iStats[17]["displayValue"].stringValue
            self._RoadKillsPG = iStats[18]["displayValue"].stringValue
            self._TeamKillsPG = iStats[19]["displayValue"].stringValue
            self._TimeSurvivedPG = iStats[20]["displayValue"].stringValue
            self._Top10sPG = iStats[21]["displayValue"].stringValue
            self._Kills = iStats[22]["displayValue"].intValue
            self._Assists = iStats[23]["displayValue"].stringValue
            self._Suicides = iStats[24]["displayValue"].stringValue
            self._TeamKills = iStats[25]["displayValue"].stringValue
            self._HeadshotKills = iStats[26]["displayValue"].stringValue
            self._HeadshotKillRatio = iStats[27]["displayValue"].stringValue
            self._VehiclesDestroyed = iStats[28]["displayValue"].stringValue
            self._RoadKills = iStats[29]["displayValue"].stringValue
            self._DailyKills = iStats[30]["displayValue"].stringValue
            self._WeeklyKills = iStats[31]["displayValue"].stringValue
            self._RoundMostKills = iStats[32]["displayValue"].stringValue
            self._MaxKillStreak = iStats[33]["displayValue"].stringValue
            self._WeaponsAquired = iStats[34]["displayValue"].stringValue
            self._DaysSurvived = iStats[35]["displayValue"].stringValue
            self._LongestTimeSurvived = iStats[36]["displayValue"].stringValue
            self._MostSurvivalTime = iStats[37]["displayValue"].stringValue
            self._AvgSurvivalTime = iStats[38]["displayValue"].stringValue
            self._WinPoints = iStats[39]["displayValue"].stringValue
            self._WalkDistance = iStats[40]["displayValue"].stringValue
            self._RideDistance = iStats[41]["displayValue"].stringValue
            self._MoveDistance = iStats[42]["displayValue"].stringValue
            self._AvgWalkDistance = iStats[43]["displayValue"].stringValue
            self._AvgRideDistance = iStats[44]["displayValue"].stringValue
            self._LongestKill = iStats[45]["displayValue"].stringValue
            self._Heals = iStats[46]["displayValue"].stringValue
            self._Revives = iStats[47]["displayValue"].stringValue
            self._Boosts = iStats[48]["displayValue"].stringValue
            self._DamageDelt = iStats[49]["displayValue"].stringValue
            self._DBNO = iStats[50]["displayValue"].stringValue
            self._KDA = "\(((iStats[22]["ValueInt"].doubleValue + iStats[23]["ValueInt"].doubleValue) / iStats[8]["ValueInt"].doubleValue).rounded(toPlaces: 2))"
            self._LK = iStats[45]["value"].doubleValue
            self._H = iStats[46]["value"].intValue
            self._TA = iStats[2]["value"].doubleValue
        }
    }

    func listPropertiesWithValues(reflect: Mirror? = nil) {
        let mirror = reflect ?? Mirror(reflecting: self)
        if mirror.superclassMirror != nil {
            self.listPropertiesWithValues(reflect: mirror.superclassMirror)
        }
        
        for (index, attr) in mirror.children.enumerated() {
            if let property_name = attr.label as String! {
                //You can represent the results however you want here!!!
                print("\(mirror.description) \(index): \(property_name) = \(attr.value)")
            }
        }
    }
}
