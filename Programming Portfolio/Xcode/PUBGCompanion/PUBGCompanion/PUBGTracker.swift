//
//  PUBGTracker.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 2/11/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation
import Alamofire
import Kanna
import SwiftyJSON

class PUBGTRACKER {
    
    fileprivate static let _instance = PUBGTRACKER()
 
    static var instance: PUBGTRACKER {
        return _instance
    }
    fileprivate static let _instance_two = PUBGTRACKER()
    
    static var instance_two: PUBGTRACKER {
        return _instance_two
    }
    //Data Structures
    fileprivate var _AllData: [String:JSON]!
    var matchHistory = [MatchHistoryMatch]()
    var playerInfo: PlayerInfo!
    var stats = [Stats]()
    var aggStats = [ComparableStats]()
    
    fileprivate var _searchAllData: [String:JSON]!
    var searchMatchHistory = [MatchHistoryMatch]()
    var searchPlayerInfo: PlayerInfo!
    var searchStats = [Stats]()
    var aggSearchStats = [ComparableStats]()
    
    //Data Structures
    var allData: [String:JSON] {
        return _AllData
    }
    var searchAllData: [String:JSON] {
        return _searchAllData
    }
    
    func PlayerData(name: String, completed:@escaping Comp) {
        matchHistory.removeAll()
        stats.removeAll()
        aggStats.removeAll()
        self._AllData = nil
        let url = URL(string:"https://pubgtracker.com/profile/pc/\(name)")!
        Alamofire.request(url).responseString { (response) in
            if let doc = HTML(response.result.value!, encoding: .utf8) {
                for script in doc.xpath("//script[contains(.,'playerData')]") {
                    if let data = script.text {
                        let dat = data.replacingOccurrences(of: "var playerData = ", with: "")
                        let d = dat.trimmingCharacters(in: .whitespacesAndNewlines)
                        let FJ = d.replacingOccurrences(of: ";", with: "")
                        let finalJSON = JSON.init(parseJSON: FJ)
                        self._AllData = finalJSON.dictionaryValue
                        for match in (self._AllData["MatchHistory"]?.arrayValue)! {
                            self.matchHistory.append(MatchHistoryMatch(match: match))
                        }
                        for statistics in (self._AllData["Stats"]?.arrayValue)! {
                            if statistics["Region"].stringValue != "agg" {
                                self.stats.append(Stats(stat: statistics))
                            } else {
                                self.aggStats.append(ComparableStats(iStats: statistics["Stats"]))
                            }
                        }
                       
                        self.playerInfo = PlayerInfo(pInfo: self._AllData, completed: { (success, msg) in
                            if (success)! {
                                completed(true, "pubgTrackerPlayerData")
//                                print(self.playerInfo.playerName)
                            }
                        })
                        
                    }
                }
            }
        }
    }
    func SerachPlayerData(name: String, completed:@escaping Comp) {
        searchMatchHistory.removeAll()
        searchStats.removeAll()
        aggSearchStats.removeAll()
        self._searchAllData = nil
        let url = URL(string:"https://pubgtracker.com/profile/pc/\(name)")!
        Alamofire.request(url).responseString { (response) in
            if let doc = HTML(response.result.value!, encoding: .utf8) {
                for script in doc.xpath("//script[contains(.,'playerData')]") {
                    if let data = script.text {
                        let dat = data.replacingOccurrences(of: "var playerData = ", with: "")
                        let d = dat.trimmingCharacters(in: .whitespacesAndNewlines)
                        let FJ = d.replacingOccurrences(of: ";", with: "")
                        let finalJSON = JSON.init(parseJSON: FJ)
                        self._searchAllData = finalJSON.dictionaryValue
                        for match in (self._searchAllData["MatchHistory"]?.arrayValue)! {
                            self.searchMatchHistory.append(MatchHistoryMatch(match: match))
                        }
                        for statistics in (self._searchAllData["Stats"]?.arrayValue)! {
                            if statistics["Region"].stringValue != "agg" {
                                self.searchStats.append(Stats(stat: statistics))
                            } else {
//                                self.aggSearchStats.append(ComparableStats(iStats: statistics.arrayValue))
                            }
                        }
                        self.searchPlayerInfo = PlayerInfo(pInfo: self.searchAllData, completed: { (success, msg) in
                            if (success)! {
                                completed(true, "pubgTrackerPlayerData")
                            }
                        })
                        
                    }
                }
            }
        }
    }
    func CompareData(data:[ComparableStats]) -> ComparableStats {
        var DataCompared: ComparableStats!
        //PLAYER ONE SORT
        let p1bestKD = data.map { $0.KDRatio }.max()
//        let p1totalKillsA = data.flatMap({$0.Kills})
//        let p1tWinsA = data.flatMap({$0.Wins})
//        let p1TW = p1tWinsA.reduce(0,+)
//        let p1TK = p1totalKillsA.reduce(0,+)
        DataCompared.KDRatio = p1bestKD!
        print(DataCompared.KDRatio)
        
        return DataCompared
    }
    func ReturnDateUpdated(date:String) -> String {
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: date)!
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale // reset the locale
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.month, .day, .hour, .minute, .second]
        formatter.maximumUnitCount = 2
        let string = formatter.string(from: date, to: Date())
        return string!
    }
    func ReturnDateUpdated_NOz(date:Double) -> String {
        let dateFormatter = DateFormatter()
        let date = NSDate(timeIntervalSince1970: date / 1000)
        dateFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss Z"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        print(date)
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.maximumUnitCount = 2
        let string = formatter.string(from: date as Date, to: Date())
        return string!
    }
    func RegionReturn(region: String) -> String {
        switch region {
        case "4":
            return "OC"
        case "2":
            return "EU"
        case "3":
            return "AS"
        case "1":
            return "NA"
        case "5":
            return "SA"
        case "6":
            return "SEA"
        case "7":
            return "KR/JP"
        default:
            break
        }
        return ""
    }
    
}
