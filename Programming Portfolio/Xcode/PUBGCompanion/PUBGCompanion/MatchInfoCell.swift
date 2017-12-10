//
//  MatchInfoCell.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 21/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Kanna

class MatchInfoCell: UITableViewCell {

    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var headshots: UILabel!
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var heals: UILabel!
    @IBOutlet weak var killRating: UILabel!
    @IBOutlet weak var assists: UILabel!
    @IBOutlet weak var boosts: UILabel!
    @IBOutlet weak var revives: UILabel!
    @IBOutlet weak var killRank: UILabel!
    @IBOutlet weak var damage: UILabel!
    @IBOutlet weak var teamKills: UILabel!
    @IBOutlet weak var suicides: UILabel!
    @IBOutlet weak var winRank: UILabel!
    @IBOutlet weak var winRating: UILabel!
    @IBOutlet weak var dbno: UILabel!
    @IBOutlet weak var roadKills: UILabel!
    @IBOutlet weak var weaponAquired: UILabel!
    @IBOutlet weak var timeAlive: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    func ConfigureCell(match: MatchHistoryMatch){
        self.rank.text = "\(match.mHRatingRank)"
        self.headshots.text = "\(match.mHHeadshots)"
        self.wins.text = "\(match.mHWins)"
        self.killRating.text = "\(match.mHKillRating)"
        self.assists.text = "\(match.mHAssists)"
        
        self.killRank.text = "\(match.mHKillRank)"
        self.damage.text = "\(match.mHDamage)"
        self.winRank.text = "\(match.mHWinRank)"
        self.winRating.text = "\(match.mHWinRating)"
        
        self.timeAlive.text = "\(match.mHTimeSurvived)"
        self.distance.text = "\(match.mHMoveDistance)"
        self.weaponAquired.text = "\(match.mHKD) %" //changed to KD
    }
    
//    func ConfigureCell(data:String){
//        if let doc = HTML(data, encoding: .utf8) {
//            for R in doc.xpath("//div[@class='col-xs-12 col-sm-6 col-md-3'][1]/div[contains(@class,'stat')][2]/div[contains(@class,'value')]") {
//                rank.text = removeModifiers(str: R.text!)
//            }
//            for KR in doc.xpath("//div[@class='col-xs-12 col-sm-6 col-md-3'][1]/div[contains(@class,'stat')][3]/div[contains(@class,'value')]") {
//                killRating.text = removeModifiers(str: KR.text!)
//            }
//            for HS in doc.xpath("//div[@class='col-xs-12 col-sm-6 col-md-3'][2]/div[contains(@class,'stat')][2]/div[contains(@class,'value')]"){
//                headshots.text = removeModifiers(str: HS.text!)
//            }
//            for W in doc.xpath("//div[@class='col-xs-12 col-sm-6 col-md-3'][3]/div[contains(@class,'stat')][1]/div[contains(@class,'value')]") {
//                let txt = doc.xpath("//div[@class='col match-header']/h3[@class='match-result']").first?.text
//                switch  txt! {
//                case "Top 10":
//                    wins.text = "0"
//                    break
//                case "Win":
//                    wins.text = "1"
//                    break
//                default:
//                    wins.text = "0"
//                    break
//                }
//
//            }
//            for H in doc.xpath("//div[@class='col-xs-12 col-sm-6 col-md-3'][4]/div[contains(@class,'stat')][1]/div[contains(@class,'value')]") {
//                heals.text = removeModifiers(str: H.text!)
//            }
//            for A in doc.xpath("//div[@class='col-xs-12 col-sm-6 col-md-3'][2]/div[contains(@class,'stat')][3]/div[contains(@class,'value')]") {
//                assists.text = removeModifiers(str: A.text!)
//            }
//            for B in doc.xpath("//div[@class='col-xs-12 col-sm-6 col-md-3'][4]/div[contains(@class,'stat')][2]/div[contains(@class,'value')]") {
//                boosts.text = removeModifiers(str: B.text!)
//            }
//            for RV in doc.xpath("//div[@class='col-xs-12 col-sm-6 col-md-3'][4]/div[contains(@class,'stat')][3]/div[contains(@class,'value')]") {
//                revives.text = removeModifiers(str: RV.text!)
//            }
//            for KRK in doc.xpath("//div[@class='col-xs-12 col-sm-6 col-md-3'][1]/div[contains(@class,'stat')][4]/div[contains(@class,'value')]") {
//                killRank.text = removeModifiers(str: KRK.text!)
//            }
//            for D in doc.xpath("//div[@class='col-xs-12 col-sm-6 col-md-3'][2]/div[contains(@class,'stat')][4]/div[contains(@class,'value')]") {
//                damage.text = removeModifiers(str: D.text!)
//            }
//            for TK in doc.xpath("//div[@class='col-xs-12 col-sm-6 col-md-3'][4]/div[contains(@class,'stat')][4]/div[contains(@class,'value')]") {
//                teamKills.text = removeModifiers(str: TK.text!)
//            }
//            for S in doc.xpath("//div[@class='col-xs-12 col-sm-6 col-md-3'][4]/div[contains(@class,'stat')][5]/div[contains(@class,'value')]") {
//                suicides.text = removeModifiers(str: S.text!)
//            }
//            for WRK in doc.xpath("//div[@class='col-xs-12 col-sm-6 col-md-3'][1]/div[contains(@class,'stat')][6]/div[contains(@class,'value')]") {
//                winRank.text = removeModifiers(str: WRK.text!)
//            }
//            for WR in doc.xpath("//div[@class='col-xs-12 col-sm-6 col-md-3'][1]/div[contains(@class,'stat')][5]/div[contains(@class,'value')]") {
//                winRating.text = removeModifiers(str: WR.text!)
//            }
//            for DBNO in doc.xpath("//div[@class='col-xs-12 col-sm-6 col-md-3'][2]/div[contains(@class,'stat')][5]/div[contains(@class,'value')]") {
//                dbno.text = removeModifiers(str: DBNO.text!)
//            }
//            for RDK in doc.xpath("//div[@class='col-xs-12 col-sm-6 col-md-3'][2]/div[contains(@class,'stat')][6]/div[contains(@class,'value')]") {
//                roadKills.text = removeModifiers(str: RDK.text!)
//            }
//            for WA in doc.xpath("//div[@class='col-xs-12 col-sm-6 col-md-3'][3]/div[contains(@class,'stat')][5]/div[contains(@class,'value')]") {
//                weaponAquired.text = removeModifiers(str: WA.text!)
//            }
//            for TA in doc.xpath("//div[@class='row']/div[@class='col'][6]/div[@class='stat']/div[@class='value']") {
//                timeAlive.text = removeModifiers(str: TA.text!)
//            }
//            for DT in doc.xpath("//div[@class='row']/div[@class='col'][5]/div[@class='stat']/div[@class='value']") {
//                distance.text = removeModifiers(str: DT.text!)
//            }
//        }
//    }
    func removeModifiers(str:String) -> String {
        let txt = str.trimmingCharacters(in: .whitespacesAndNewlines)
        if let range = txt.range(of: "(") {
            let txtF = txt.substring(to: range.lowerBound)
            let txtFinal = txtF.replacingOccurrences(of: " ", with: "")
            return txtFinal
        } else {
            let txtFinal = txt.replacingOccurrences(of: " ", with: "")
            return txtFinal
        }
    }
}
