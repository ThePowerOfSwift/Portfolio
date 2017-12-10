//
//  PUBGMeStats.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 19/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import Kanna

typealias Comp = (_ suc: Bool?, _ em: String?) -> ()
typealias Complete = (_ suc: Bool?, _ em: String?, _ d: Any) -> ()
typealias Completed = (_ suc: Bool?, _ em: String?, _ d: Any, _ d2: Any) -> ()

class PUBGME {
    
    fileprivate static let _instance = PUBGME()
    
    static var instance: PUBGME {
        return _instance
    }
    
    fileprivate static let _instance2 = PUBGME()
    
    static var instance2: PUBGME {
        return _instance2
    }
    
    private var overallHTMLData: String!
    
    var _overallHTMLData: String! {
        return overallHTMLData
    }
    private var matchHistoryData = [String]()
    
    private var mHistoryLinks: String!
    
    var _mHistoryLinks: String {
        return mHistoryLinks
    }
    
    var _matchHistoryData: [String] {
        return matchHistoryData
    }
    
    
    func PubgmeOverview(name:String, completed:@escaping Complete){
        let overviewData = UserDefaults.standard.string(forKey: "overviewData")
        if (overviewData != nil) {
            if let lastUpdate = UserDefaults.standard.object(forKey: "lastUpdatedOverview") as? Date {
                let elapsedTime = NSDate().timeIntervalSince(lastUpdate)
                if elapsedTime > 900 {
                    let str = "\(NODEBASEURL)/Stats/\(name)"
                    let u = URL(string: str)
                    let urlRequest = URLRequest(url: u!)
                    Alamofire.request(urlRequest).responseString(encoding: String.Encoding.utf8) { (htmlData) in
                        if let data = htmlData.result.value {
                            UserDefaults.standard.set(data, forKey: "overviewData")
                            UserDefaults.standard.set(Date(), forKey: "lastUpdatedOverview")
                            self.overallHTMLData = UserDefaults.standard.string(forKey: "overviewData")
                            if let doc = HTML(self.overallHTMLData, encoding: .utf8) {
                                if let defaultRegion = doc.xpath("//div[@class='profile-header-stats'][2]/div[@class='stat']/div[@class='value']").first?.text {

                                    let dRegion = PUBGME.instance.RegionReturn(region: defaultRegion)
                                    UserDefaults.standard.set(dRegion, forKey: "defaultRegion")
                                }
                            }
                            completed(true,"OverallData", self.overallHTMLData)
                        }
                    }
                } else {
                    self.overallHTMLData = overviewData
                    
                    completed(true,"OverallData", overviewData)
                }
            } else {
                let str = "\(NODEBASEURL)/Stats/\(name)"
                let u = URL(string: str)
                let urlRequest = URLRequest(url: u!)
                Alamofire.request(urlRequest).responseString(encoding: String.Encoding.utf8) { (htmlData) in
                    if let data = htmlData.result.value {
                        self.overallHTMLData = data
                        UserDefaults.standard.set(data, forKey: "overviewData")
                        UserDefaults.standard.set(Date(), forKey: "lastUpdatedOverview")
                        completed(true,"OverallData", data)
                    }
                }
            }
            
        } else {
            let str = "\(NODEBASEURL)/Stats/\(name)"
            let u = URL(string: str)
            let urlRequest = URLRequest(url: u!)
            Alamofire.request(urlRequest).responseString(encoding: String.Encoding.utf8) { (htmlData) in
                if let data = htmlData.result.value {
                    self.overallHTMLData = data
                    UserDefaults.standard.set(data, forKey: "overviewData")
                    UserDefaults.standard.set(Date(), forKey: "lastUpdatedOverview")
                    completed(true,"OverallData", data)
                }
            }
        }

    }
    
    func OverView(name: String, completed: @escaping Complete) {

    }
    
    func PubgmeMatchHistoryShareStats(ID:String, completed: @escaping Complete) {
        let str = "https://pubg.me/\(ID)"

        let u = URL(string: str)
        let urlRequest = URLRequest(url: u!)
        Alamofire.request(urlRequest).responseString(encoding: String.Encoding.utf8) { (htmlData) in
            if let data = htmlData.result.value {
                completed(true,"MatchHistoryShareStats", data)
            }
        }
    }
    
    func PubgmeShareStats(name:String, season:String, mode:String, region:String, completed: @escaping Complete) {
        let str = "\(NODEBASEURL)/StatsShare/\(name)/\(season)/\(mode.lowercased())/\(region.lowercased())"
        let u = URL(string: str)
        let urlRequest = URLRequest(url: u!)
        Alamofire.request(urlRequest).responseString(encoding: String.Encoding.utf8) { (htmlData) in
            if let data = htmlData.result.value {
                completed(true,"ShareStats", data)
            }
        }
    }
    
    func PubgmePreviousSeasons(name: String,region: String,season: String,completed:@escaping Complete) {
        let str = "\(NODEBASEURL)/PreviousSeasons/\(name)/\(season)/\(region)"
        let u = URL(string: str)
        let urlRequest = URLRequest(url: u!)
        Alamofire.request(urlRequest).responseString(encoding: String.Encoding.utf8) { (htmlData) in
            if let data = htmlData.result.value {
                completed(true,"prevSeason", data)
            }
        }
    }
    
    func PubgmeMatchHistory(name: String,pageNumber: String, completed: @escaping Complete){
        let str = "\(NODEBASEURL)/MatchHistory/\(name)/\(pageNumber)"
        let u = URL(string: str)
        let urlRequest = URLRequest(url: u!)
        Alamofire.request(urlRequest).responseString(encoding: String.Encoding.utf8) { (htmlData) in
            if let data = htmlData.result.value {
                completed(true,"MatchHistory", data)
                self.mHistoryLinks = data
                self.ParseMatchHistory(data: data, completed: { (success, msg, data) in })
                
            }
        }
    }
    
    func ParseMatchHistoryPageCount(data: String, completed:Completed){
        var pageNumbers = [String]()
        var PLHelper = [String]()
        var pageLinks =  [String]()
        if let doc = HTML( data, encoding: .utf8) {
            for pageLink in doc.xpath("//div[@class='mb-3']/ul[@class='pagination mt-3']/li[@class='page-item']|//div[@class='mb-3']/ul[@class='pagination mt-3']/li[@class='page-item active'] ") {
                if pageLink.text == "..." || pageLink.text == "" {
                    
                } else {
                    pageNumbers.append(pageLink.text!)
                    PLHelper.append(pageLink.innerHTML!)
                }
            }
            for pagination in PLHelper {
                if let doc = HTML( pagination, encoding: .utf8) {
                    let pageL = doc.xpath("//a/@href").first
                    let page = pageL?.text!.replacingOccurrences(of: "?page=", with: "")
                    pageLinks.append(page!)
                }
            }
            
            completed(true,"matchPages",pageNumbers,pageLinks)
        }
        
    }
    
    func ParseMatchHistory(data:String!, completed: Complete) {
        var matchData = [String]()
        if let doc = HTML(data, encoding: .utf8){
            for mData in doc.xpath("//div[@class='match-history-page']/div") {
                matchData.append(mData.innerHTML!)
            }
            matchHistoryData = matchData
            completed(true,"matchHistory",matchData)
        }
    }
    
    func ParseCurrentSeason(data:String, completed: Complete) {
        if let doc = HTML( data, encoding: .utf8){
            let currentSeason = doc.xpath("//div[@class='profile-header-stats'][1]/div[@class='stat']/div[@class='value']").first
            if let CS = currentSeason?.text {
                completed(true, "currentSeason", CS)
            }
        }
    }
    
    func ParseKillsWinsRounds(data:String, completed: Complete) {
        if let doc = HTML(data, encoding: .utf8) {
            var info = [String]()
            
            let k = doc.xpath("//div[@class='card-header card-header-large profile-header d-flex align-self-stretch justify-content-end']/div[@class='profile-header-stats d-flex flex-column justify-content-center'][2]/div[@class='stat  stat-red']/div[@class='value value-red']").first
            let w = doc.xpath("//div[@class='card-header card-header-large profile-header d-flex align-self-stretch justify-content-end']/div[@class='profile-header-stats d-flex flex-column justify-content-center'][1]/div[@class='stat  stat-yellow']/div[@class='value value-yellow']").first
            let rp = doc.xpath("//div[@class='card-header card-header-large profile-header d-flex align-self-stretch justify-content-end']/div[@class='profile-header-stats d-flex flex-column justify-content-center'][1]/div[@class='stat']/div[@class='value']").first
            
            info.append((k?.text!)!)
            info.append((w?.text!)!)
            info.append((rp?.text!)!)
            
            completed(true,"KillsWinsRounds",info)
        }
    }
    
    func ParseUserImage(data:String, completed:@escaping Complete) {
        if let doc = HTML( data, encoding: .utf8) {
            
            for img in doc.xpath("//div[@class='profile-avatar']/img/@src"){
                let dataSource = img.innerHTML!
                let strippedData = dataSource.replacingOccurrences(of: "src=", with: "")
                let finalData = strippedData.replacingOccurrences(of: "\"", with: "")
                let final = finalData.replacingOccurrences(of: " ", with: "")
                Alamofire.request(final).responseImage(completionHandler: { (imgResp) in
                    completed(true,"UserImage",imgResp.result.value as Any)
                })
            }
            
            
        }
    }
    
    func ParseSeasonRegion(data: String, completed: Complete){
        var MD: [String:[String]] = ["Season 5":[],"Season 4":[],"Season 3":[],"Season 2":[],"Season 1":[]]
        
        if let doc = HTML( data, encoding: .utf8){
            for SR in doc.xpath("//li[@class='nav-item dropdown active']/div[@class='dropdown-menu dropdown-menu-compare dropdown-menu-profile-overview']/a/@href"){
                let range1 = SR.text?.range(of: "?")
                let endStr = SR.text?.substring(from: (range1?.upperBound)!)
                let range2 = endStr?.range(of: "&")
                let season =  endStr?.substring(to: (range2?.lowerBound)!)
                let region = endStr?.substring(from: (range2?.upperBound)!)
                if let finalSeason = season?.replacingOccurrences(of: "season=", with: ""), let _ = region?.replacingOccurrences(of: "region=", with: ""){
                    
                    MD[ReturnSeasonString(season: finalSeason)]?.append("https://pubg.me\(SR.text!)")
                }
            }
            completed(true, "Season Data", MD)
        }
        
    }
    
    func ParseCellData(data:String, completed: Complete) {
        
        var pubgmeCelldata = [String]()
        
        if let doc = HTML( data, encoding: .utf8){
            
            for cell in doc.xpath("//div[@class='card profile-match-overview']") {
                pubgmeCelldata.append(cell.innerHTML!)
            }
            completed(true, "Season Data", pubgmeCelldata)
        }
    }
    
    func RegionHrefChange(href: String) -> String{
        let range1 = href.range(of: "?")
        let endStr = href.substring(from: (range1?.upperBound)!)
        let range2 = endStr.range(of: "&")
        let region = endStr.substring(from: (range2!.upperBound))
        let finalRegion = region.replacingOccurrences(of: "region=", with: "")
        return finalRegion.uppercased()
    }
    
    func ReturnSeasonString(season:String) -> String {
        switch season {
        case "2017-pre5":
            return "Season 5"
        case "2017-pre4":
            return "Season 4"
        case "2017-pre3":
            return "Season 3"
        case "2017-pre2":
            return "Season 2"
        case "2017-pre1":
            return "Season 1"
        default:
            break
        }
        return ""
    }
    
    func ReturnSeasonHref(season:String) -> String {
        switch season {
        case "Season 5":
            return "2017-pre5"
        case "Season 4":
            return "2017-pre4"
        case "Season 3":
            return "2017-pre3"
        case "Season 2":
            return "2017-pre2"
        case "Season 1":
            return "2017-pre1"
        default:
            break
        }
        return ""
    }
    
    func eaStrChange(earlyAccess: String) -> String {
        switch earlyAccess {
        case "Early Access #5":
            return "Season 5"
        case "Early Access #4":
            return "Season 4"
        case "Early Access #3":
            return "Season 3"
        case "Early Access #2":
            return "Season 2"
        case "Early Access #1":
            return "Season 1"
        default:
            break
        }
        return ""
    }
    func ModeReturn(mode:String) -> String {
        switch mode {
        case "Solo":
            return "solo"
        case "Duo":
            return "duo"
        case "Squad":
            return "squad"
        case "SoloFPP":
            return "solo-fpp"
        case "DuoFPP":
            return "duo-fpp"
        case "SquadFPP":
            return "squad-fpp"
        default:
            break
        }
        return ""
    }
    func RegionReturn(region: String) -> String {
        switch region {
        case "Oceania":
            return "oc"
        case "Europe":
            return "eu"
        case "Asia":
            return "as"
        case "North America":
            return "na"
        case "South America":
            return "sa"
        case "Southeast Asia":
            return "sea"
        case "Korea/Japan":
            return "krjp"
        default:
            break
        }
        return ""
    }
}
