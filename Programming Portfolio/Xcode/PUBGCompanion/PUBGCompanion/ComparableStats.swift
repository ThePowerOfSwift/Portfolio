//
//  ComparableStats.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 24/11/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation
import SwiftyJSON

class ComparableStats {
    fileprivate var _KDRatio: Double!
    fileprivate var _WinPercent: Double!
    fileprivate var _TimeSurvived: Double!
    fileprivate var _RoundsPlayed: Double!
    fileprivate var _Wins: Int!
    fileprivate var _WinTop10Ratio: Double!
    fileprivate var _Tope10s: Double!
    fileprivate var _Top10Ratio: Double!
    fileprivate var _Losses: Double!
    fileprivate var _Rating: Double!
    fileprivate var _Rank: Double!
    fileprivate var _BestRating: Double!
    fileprivate var _BestRank: Double!
    fileprivate var _AvgDmgPerMatch: Double!
    fileprivate var _TimeSurvivedPG: Double!
    fileprivate var _Top10sPG: Double!
    fileprivate var _Kills: Int!
    fileprivate var _Assists: Double!
    fileprivate var _Suicides: Double!
    fileprivate var _TeamKills: Double!
    fileprivate var _HeadshotKills: Double!
    fileprivate var _HeadshotKillRatio: Double!
    fileprivate var _VehiclesDestroyed: Double!
    fileprivate var _RoadKills: Double!
    fileprivate var _DailyKills: Double!
    fileprivate var _WeeklyKills: Double!
    fileprivate var _RoundMostKills: Double!
    fileprivate var _MaxKillStreak: Double!
    fileprivate var _WeaponsAquired: Double!
    fileprivate var _DaysSurvived: Double!
    fileprivate var _LongestTimeSurvived: Double!
    fileprivate var _MostSurvivalTime: Double!
    fileprivate var _AvgSurvivalTime: Double!
    fileprivate var _WinPoints: Double!
    fileprivate var _WalkDistance: Double!
    fileprivate var _RideDistance: Double!
    fileprivate var _MoveDistance: Double!
    fileprivate var _AvgWalkDistance: Double!
    fileprivate var _AvgRideDistance: Double!
    fileprivate var _LongestKill: Double!
    fileprivate var _Heals: Double!
    fileprivate var _Revives: Double!
    fileprivate var _Boosts: Double!
    fileprivate var _DamageDelt: Double!
    fileprivate var _DBNO: Double!
    fileprivate var _KDA: String!
    
    var KDRatio: Double {
        get {
        return _KDRatio
        } set  {
            if _KDRatio > KDRatio {
                _KDRatio = newValue
            }
        }
        
    }
    var WinPercent: Double {
        return _WinPercent
    }
    var TimeSurvived: Double {
        return _TimeSurvived
    }
    var RoundsPlayed: Double {
        return _RoundsPlayed
    }
    var Wins: Int {
        return _Wins
    }
    var WinTop10Ratio: Double {
        return _WinTop10Ratio
    }
    var Top10s: Double {
        return _Tope10s
    }
    var Top10Ratio: Double {
        return _Top10Ratio
    }
    var Losses: Double {
        return _Losses
    }
    var Rating: Double {
        return _Rating
    }
    var Rank: Double {
        return _Rank
    }
    var BestRating:Double {
        return _BestRating
    }
    var BestRank: Double {
        return _BestRank
    }
    var AvgDmgPerMatch: Double {
        return _AvgDmgPerMatch
    }

    var TimeSurvivedPG: Double {
        return _TimeSurvivedPG
    }
    var Top10sPG: Double {
        return _Top10sPG
    }
    var Kills: Int {
        return _Kills
    }
    var Assists: Double {
        return _Assists
    }
    var Suicides: Double {
        return _Suicides
    }
    var TeamKills: Double {
        return _TeamKills
    }
    var HeadshotsKills: Double {
        return _HeadshotKills
    }
    var HeadshotKillRatio: Double {
        return _HeadshotKillRatio
    }
    var VehiclesDestroyed: Double {
        return _VehiclesDestroyed
    }
    var RoadKills: Double {
        return _RoadKills
    }
    var DailyKills: Double {
        return _DailyKills
    }
    var WeeklyKills: Double {
        return _WeeklyKills
    }
    var RoundMostKills: Double {
        return _RoundMostKills
    }
    var MaxKillStreak: Double {
        return _MaxKillStreak
    }
    var WeaponsAquired: Double {
        return _WeaponsAquired
    }
    var DaysSurvived: Double {
        return _DaysSurvived
    }
    var LongestTimeSurvuved: Double {
        return _LongestTimeSurvived
    }
    var MostSurvivalTime: Double {
        return _MostSurvivalTime
    }
    var AvgSurvivalTime: Double {
        return _AvgSurvivalTime
    }
    var WinPoints: Double {
        return _WinPoints
    }
    var WalkDistance: Double {
        return _WalkDistance
    }
    var RideDistance: Double {
        return _RideDistance
    }
    var MoveDistance: Double {
        return _MoveDistance
    }
    var AvgWalkDistance: Double {
        return _AvgWalkDistance
    }
    var AvgRideDistance: Double {
        return _AvgRideDistance
    }
    var LongestKill: Double {
        return _LongestKill
    }
    var Heals: Double {
        return _Heals
    }
    var Revives: Double {
        return _Revives
    }
    var Boosts: Double {
        return _Boosts
    }
    var DamageDelt: Double {
        return _DamageDelt
    }
    var DBNO: Double {
        return _DBNO
    }
    var KDA: String {
        return _KDA
    }
    
    init(iStats: JSON) {
        self._KDRatio = iStats[0]["value"].doubleValue
        self._WinPercent = iStats[1]["displayValue"].doubleValue
        self._TimeSurvived = iStats[2]["displayValue"].doubleValue
        self._RoundsPlayed = iStats[3]["displayValue"].doubleValue
        self._Wins = iStats[4]["displayValue"].intValue
        self._WinTop10Ratio = iStats[5]["displayValue"].doubleValue
        self._Tope10s = iStats[6]["displayValue"].doubleValue
        self._Top10Ratio = iStats[7]["displayValue"].doubleValue
        self._Losses = iStats[8]["displayValue"].doubleValue
        self._Rating = iStats[9]["displayValue"].doubleValue
        self._Rank = iStats[9]["rank"].doubleValue
        self._BestRating = iStats[10]["displayValue"].doubleValue
        self._BestRank = iStats[11]["displayValue"].doubleValue
        self._AvgDmgPerMatch = iStats[12]["displayValue"].doubleValue
        self._Kills = iStats[22]["displayValue"].intValue
        self._Assists = iStats[23]["displayValue"].doubleValue
        self._Suicides = iStats[24]["displayValue"].doubleValue
        self._TeamKills = iStats[25]["displayValue"].doubleValue
        self._HeadshotKills = iStats[26]["displayValue"].doubleValue
        self._HeadshotKillRatio = iStats[27]["displayValue"].doubleValue
        self._VehiclesDestroyed = iStats[28]["displayValue"].doubleValue
        self._RoadKills = iStats[29]["displayValue"].doubleValue
        self._DailyKills = iStats[30]["displayValue"].doubleValue
        self._WeeklyKills = iStats[31]["displayValue"].doubleValue
        self._RoundMostKills = iStats[32]["displayValue"].doubleValue
        self._MaxKillStreak = iStats[33]["displayValue"].doubleValue
        self._WeaponsAquired = iStats[34]["displayValue"].doubleValue
        self._DaysSurvived = iStats[35]["displayValue"].doubleValue
        self._LongestTimeSurvived = iStats[36]["displayValue"].doubleValue
        self._MostSurvivalTime = iStats[37]["displayValue"].doubleValue
        self._AvgSurvivalTime = iStats[38]["displayValue"].doubleValue
        self._WinPoints = iStats[39]["value"].doubleValue
        self._WalkDistance = iStats[40]["displayValue"].doubleValue
        self._RideDistance = iStats[41]["displayValue"].doubleValue
        self._MoveDistance = iStats[42]["displayValue"].doubleValue
        self._AvgWalkDistance = iStats[43]["displayValue"].doubleValue
        self._AvgRideDistance = iStats[44]["displayValue"].doubleValue
        self._LongestKill = iStats[45]["displayValue"].doubleValue
        self._Heals = iStats[46]["displayValue"].doubleValue
        self._Revives = iStats[47]["displayValue"].doubleValue
        self._Boosts = iStats[48]["displayValue"].doubleValue
        self._DamageDelt = iStats[49]["displayValue"].doubleValue
        self._DBNO = iStats[50]["displayValue"].doubleValue
        self._KDA = "\(((iStats[22]["ValueInt"].doubleValue + iStats[23]["ValueInt"].doubleValue) / iStats[8]["ValueInt"].doubleValue).rounded(toPlaces: 2))"
    }
}
