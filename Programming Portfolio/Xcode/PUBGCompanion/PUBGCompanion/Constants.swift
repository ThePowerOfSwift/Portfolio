//
//  Constants.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 2/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation
import UIKit
//System Colours
public var DARK_GREY = UIColor(red: 36/255, green: 35/255, blue: 35/255, alpha: 1.0)
public var LIGHT_GREY = UIColor(red: 65/255, green: 63/255, blue: 65/255, alpha: 1.0)
public var Y_ORANGE = UIColor(red: 246/255, green: 159/255, blue: 18/255, alpha: 1.0)
public var GREEN = UIColor(red: 158/255, green: 259/255, blue: 82/255, alpha: 0.74)
public var RED = UIColor(red: 255/255, green: 10/255, blue: 9/255, alpha: 0.74)
public var BLUE = UIColor(red: 0/255, green: 168/255, blue: 255/255, alpha: 0.74)
//Google AdMob
public var ADUNITID = "ca-app-pub-7739741947193555/2452537361"
public var TESTDEVICE = "60777a953ed3effdb189d9ae107932ba"
//Youtube API Key
public let YOUTUBEKEY = "AIzaSyDi9tRUJXBwfEEmjrEi8tqK6-l3aoysR1w"
//PUBG Map
public var MAP_URLS = ["https://pubgmap.io/erangel.html"]
//Custom PUBG item info API
public var ALLDATA = URL(string:"https://pubghub.herokuapp.com/PUBGHubApi")
//Gify API Key
public let GIFYAPIKEY = "gF5TQUZNqMy9mlI5bicgtTuf0ow0uSC7"
//NodeJS API
public let NODEBASEURL = "https://pubghub.herokuapp.com/pubg"



////OLD CODE

//            playerName.text = UserDefaults.standard.string(forKey: "playerName")
//            let r = doc.xpath("//div[@class='profile-dropdown card-header dropdown-toggle d-flex align-items-center']/div[@class='profile-header-stats'][2]/div[@class='stat']/div[@class='value']").first?.text!
//            shareLabel.text = "\(link.season.uppercased()) - \(link.mode.uppercased()) - \(r!.uppercased())"
//
//            for lastU in doc.xpath("//div[@class='last-updated']") {
//                lastUpdated.text = lastU.text!
//            }
//            for ratingValue in doc.xpath("//div[@class='card mb-3'][2]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat stat-large stat-blue']/div[@class='value value-blue']") {
//                modeRatingValue.text = ratingValue.text!
//            }
//            for ratingLabel in doc.xpath("//div[@class='card mb-3'][2]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat stat-large stat-blue']/div[@class='label label-blue']") {
//                modeRatingLabel.text = ratingLabel.text!.uppercased()
//            }
//            for seasonH in doc.xpath("//div[@class='card mb-3'][2]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat'][1]/div[@class='value']") {
//                seasonHigh.text = seasonH.text!
//            }
//            for r in doc.xpath("//div[@class='card mb-3'][2]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat'][2]/div[@class='value']") {
//                rank.text = r.text!
//            }
//            for winP in doc.xpath("//div[@class='card mb-3'][2]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat stat-large stat-green']/div[@class='value value-green']") {
//                winRate.text = winP.text!
//            }
//            for w in doc.xpath("//div[@class='card mb-3'][2]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat'][1]/div[@class='value']") {
//                wins.text = w.text!
//            }
//            for winR in doc.xpath("//div[@class='card mb-3'][2]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat'][2]/div[@class='value']") {
//                winRank.text = winR.text!
//            }
//            for kdr in doc.xpath("//div[@class='card mb-3'][2]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat stat-large stat-red']/div[@class='value value-red']") {
//                kdRatio.text = kdr.text!
//            }
//            for k in doc.xpath("//div[@class='card mb-3'][2]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat'][1]/div[@class='value']") {
//                kills.text = k.text!
//            }
//            for killR in doc.xpath("//div[@class='card mb-3'][2]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat'][2]/div[@class='value']") {
//                killRank.text = killR.text!
//            }
//
//            for mP in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat stat-large stat-blue']/div[@class='value value-blue']") {
//                matchesPlayed.text = mP.text!
//            }
//
//            for dL in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat'][1]/div[@class='value']") {
//                dailyLogins.text = dL.text!
//            }
//            for avgDT in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat'][2]/div[@class='value']") {
//                avgDistTravelled.text = avgDT.text!
//            }
//            for tDT in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat'][3]/div[@class='value']") {
//                totalDistanceTravelled.text = tDT.text!
//            }
//            for avgDF in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat'][4]/div[@class='value']") {
//                avgDistOnFoot.text = avgDF.text!
//            }
//            for avgDV in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat'][5]/div[@class='value']") {
//                avgDistInVehicle.text = avgDV.text!
//            }
//            for wA in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat'][6]/div[@class='value']") {
//                weaponsAquired.text = wA.text!
//            }
//            for vD in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat'][7]/div[@class='value']") {
//                vehiclesDestroyed.text = vD.text!
//            }
//            for tDD in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][1]/div[@class='stat'][8]/div[@class='value']") {
//                totalDmgDelt.text = tDD.text!
//            }
//            for ttR in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat stat-large stat-green']/div[@class='value value-green']") {
//                top10Rate.text = ttR.text!
//            }
//            for tTS in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat'][1]/div[@class='value']") {
//                top10s.text = tTS.text!
//            }
//            for avgTS in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat'][2]/div[@class='value']") {
//                avgTimeSurvived.text = avgTS.text!
//            }
//            for lTS in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat'][3]/div[@class='value']") {
//                longestTimeSurvived.text = lTS.text!
//            }
//            for tH in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat'][4]/div[@class='value']") {
//                totalHeals.text = tH.text!
//            }
//            for tB in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat'][5]/div[@class='value']") {
//                totalBoosts.text = tB.text!
//            }
//            for tK in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat'][6]/div[@class='value']") {
//                teamkills.text = tK.text!
//            }
//            for s in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat'][7]/div[@class='value']") {
//                suicides.text = s.text!
//            }
//            for r in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][2]/div[@class='stat'][8]/div[@class='value']") {
//                revives.text = r.text!
//            }
//            for avgDPM in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat stat-large stat-red']/div[@class='value value-red']") {
//                avgDmgPerMatch.text = avgDPM.text!
//            }
//            for mKIM in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat'][1]/div[@class='value']"){
//                killsInMatch.text = mKIM.text!
//            }
//            for a in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat'][2]/div[@class='value']") {
//                assists.text = a.text!
//            }
//            for kDA in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat'][3]/div[@class='value']") {
//                kda.text = kDA.text!
//            }
//            for h in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat'][4]/div[@class='value']") {
//                headshots.text = h.text!
//            }
//            for hKR in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat'][5]/div[@class='value']") {
//                headshotKillRatio.text = hKR.text!
//            }
//            for lK in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat'][6]/div[@class='value']") {
//                longestKill.text = lK.text!
//            }
//            for rK in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat'][7]/div[@class='value']") {
//                roadKills.text = rK.text!
//            }
//            for bKS in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat'][8]/div[@class='value']") {
//                bestKillStreak.text = bKS.text!
//            }
//            for dBNO in doc.xpath("//div[@class='card mb-3'][3]/div[contains(@class,'profile-match-overview')]/div[@class='row']/div[@class='col-md-4'][3]/div[@class='stat'][9]/div[@class='value']") {
//                dbno.text = dBNO.text!
//            }
