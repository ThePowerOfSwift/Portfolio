//
//  ExtendedStatsCell.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 10/11/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit


class ExtendedStatsCell: UICollectionViewCell {
    @IBOutlet weak var viewToImage: UIView!
    
    @IBOutlet weak var backgroundView1: UIView!
    @IBOutlet weak var backgroundView2: UIView!
    @IBOutlet weak var backgroundView3: UIView!
    
    
    
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var lastUpdated: UILabel!
    
    @IBOutlet weak var modeRatingValue: UILabel!
    @IBOutlet weak var seasonHigh: UILabel!
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var winRate: UILabel!
    @IBOutlet weak var wins: UILabel!
    @IBOutlet weak var winRank: UILabel!
    @IBOutlet weak var kdRatio: UILabel!
    @IBOutlet weak var kills: UILabel!
    @IBOutlet weak var killRank: UILabel!
    @IBOutlet weak var matchesPlayed: UILabel!
    @IBOutlet weak var top10Rate: UILabel!
    @IBOutlet weak var avgDmgPerMatch: UILabel!
    @IBOutlet weak var dailyLogins: UILabel!
    @IBOutlet weak var top10s: UILabel!

    @IBOutlet weak var avgDistTravelled: UILabel!
    @IBOutlet weak var avgTimeSurvived: UILabel!
    @IBOutlet weak var assists: UILabel!
    @IBOutlet weak var totalDistanceTravelled: UILabel!
    @IBOutlet weak var longestTimeSurvived: UILabel!
    @IBOutlet weak var kda: UILabel!
    @IBOutlet weak var avgDistOnFoot: UILabel!
    @IBOutlet weak var totalHeals: UILabel!
    @IBOutlet weak var headshots: UILabel!
    @IBOutlet weak var avgDistInVehicle: UILabel!
    @IBOutlet weak var totalBoosts: UILabel!
    @IBOutlet weak var headshotKillRatio: UILabel!
    @IBOutlet weak var weaponsAquired: UILabel!
    @IBOutlet weak var teamkills: UILabel!
    @IBOutlet weak var longestKill: UILabel!
    @IBOutlet weak var vehiclesDestroyed: UILabel!
    @IBOutlet weak var suicides: UILabel!
    @IBOutlet weak var roadKills: UILabel!
    @IBOutlet weak var revives: UILabel!
    @IBOutlet weak var bestKillStreak: UILabel!
    @IBOutlet weak var dbno: UILabel!
    @IBOutlet weak var totalDmgDelt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundView1.layer.cornerRadius = 3
        backgroundView2.layer.cornerRadius = 3
        backgroundView3.layer.cornerRadius = 3
        viewToImage.layer.cornerRadius = 3
        self.contentView.autoresizingMask.insert(.flexibleHeight)
        self.contentView.autoresizingMask.insert(.flexibleWidth)
    }
    
    func ConfigureCell(data: Stats, pImage: UIImage, pName: String, lUpdated: String) {
        shareLabel.text = "\(PUBGME.instance.ReturnSeasonString(season: data.Season)) - \(data.Region.uppercased()) - \(data.Match.uppercased())"
        lastUpdated.text = lUpdated
        playerName.text = pName
        playerImage.image = pImage
        modeRatingValue.text = data.individualStats.Rating
        seasonHigh.text = data.individualStats.BestRank
        rank.text = data.individualStats.Rank
        winRate.text = data.individualStats.WinPercent
        wins.text = "\(data.individualStats.Wins)"
        winRank.text = "\(data.individualStats.WinTop10Ratio)"
        kdRatio.text = data.individualStats.KDRatio
        kills.text = "\(data.individualStats.Kills)"
        killRank.text = data.individualStats.Losses
        matchesPlayed.text = data.individualStats.RoundsPlayed
        top10Rate.text = data.individualStats.Top10Ratio
        avgDmgPerMatch.text = data.individualStats.AvgDmgPerMatch
        dailyLogins.text = data.individualStats.DailyKills
        top10s.text = data.individualStats.Top10s
        avgDistTravelled.text = data.individualStats.MoveDistancePG
        avgTimeSurvived.text = data.individualStats.AvgSurvivalTime
        assists.text = data.individualStats.Assists
        totalDistanceTravelled.text = data.individualStats.MoveDistance
        longestTimeSurvived.text = data.individualStats.LongestTimeSurvuved
        kda.text = data.individualStats.KDA
        avgDistOnFoot.text = data.individualStats.AvgWalkDistance
        totalHeals.text = data.individualStats.Heals
        headshots.text = data.individualStats.HeadshotsKills
        avgDistInVehicle.text = data.individualStats.AvgRideDistance
        totalBoosts.text = data.individualStats.Boosts
        headshotKillRatio.text = "\(data.individualStats.HeadshotKillRatio) %"
        weaponsAquired.text = data.individualStats.WeaponsAquired
        teamkills.text = data.individualStats.TeamKills
        longestKill.text = data.individualStats.LongestKill
        vehiclesDestroyed.text = data.individualStats.VehiclesDestroyed
        suicides.text = data.individualStats.Suicides
        roadKills.text = data.individualStats.RoadKills
        revives.text = data.individualStats.Revives
        bestKillStreak.text = data.individualStats.MaxKillStreak
        dbno.text = data.individualStats.DBNO
        totalDmgDelt.text = data.individualStats.DamageDelt
        
    }
    
    func ParseHtml(data:String!){
        self.playerImage.image = data as? UIImage
        self.playerImage.clipsToBounds = true
        self.playerImage.layer.cornerRadius = 20
        self.viewToImage.isHidden = false
        
        

        
        
    }
}
