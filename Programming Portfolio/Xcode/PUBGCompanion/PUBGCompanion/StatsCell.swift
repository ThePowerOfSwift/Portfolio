//
//  OverallStatsCell.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 1/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Kanna

class StatisticsCell: UICollectionViewCell {
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingValue: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankValue: UILabel!
    @IBOutlet weak var matchesPlayedLabel: UILabel!
    @IBOutlet weak var matchesPlayedValue: UILabel!
    @IBOutlet weak var winRateLabel: UILabel!
    @IBOutlet weak var winRateValue: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var winsValue: UILabel!
    @IBOutlet weak var top10countLabel: UILabel!
    @IBOutlet weak var top10countValue: UILabel!
    @IBOutlet weak var kdLabel: UILabel!
    @IBOutlet weak var kdValue: UILabel!
    @IBOutlet weak var killsLabel: UILabel!
    @IBOutlet weak var killsValue: UILabel!

    @IBOutlet weak var cellTitle: UILabel!
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var sView1: UIView!
    @IBOutlet weak var sView2: UIView!
    @IBOutlet weak var sView3: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBackground.layer.cornerRadius = 3
        sView1.layer.cornerRadius = 3
        sView2.layer.cornerRadius = 3
        sView3.layer.cornerRadius = 3
        self.contentView.autoresizingMask.insert(.flexibleHeight)
        self.contentView.autoresizingMask.insert(.flexibleWidth)
    }
    
    func ConfigureCell(stat: Stats) {
        self.ratingValue.text = stat.individualStats.Rating
        self.rankValue.text = stat.individualStats.Rank
        self.matchesPlayedValue.text = stat.individualStats.RoundsPlayed
        self.winRateValue.text = stat.individualStats.WinPercent
        self.winsValue.text = "\(stat.individualStats.Wins)"
        self.top10countValue.text = stat.individualStats.Top10s
        self.kdValue.text = stat.individualStats.KDRatio
        self.killsValue.text = "\(stat.individualStats.Kills)"
        self.cellTitle.text = "\(stat.Match.uppercased()) - \(stat.Region.uppercased())"
    }
    
//    func ConfigureCell(data:String) {
//        if let doc = HTML( data, encoding: .utf8) {
//            let rl = doc.xpath("//div[@class='label label-blue']").first?.text
//            let wrl = doc.xpath("//div[@class='label label-green']").first?.text
//            let kdl = doc.xpath("//div[@class='label label-red']").first?.text
//            let rankL = doc.xpath("//div[contains(@class,'profile-overview-stat-row')]//div[@class='col col-lg-3'][2]//div[@class='stat']/div[@class='label']").first?.text
//            let rankV = doc.xpath("//div[contains(@class,'profile-overview-stat-row')]//div[@class='col col-lg-3'][2]//div[@class='stat']/div[@class='value']").first?.text
//            let cellT = doc.xpath("//div[@class='profile-match-overview-name']").first?.text
//            let mpl = doc.xpath("//div[contains(@class,'profile-overview-stat-row')]//div[@class='col col-lg-3'][1]//div[@class='stat']/div[@class='label']").first?.text
//            let mpv = doc.xpath("//div[contains(@class,'profile-overview-stat-row')]//div[@class='col col-lg-3'][1]//div[@class='stat']/div[@class='value']").first?.text
//            let top10rv = doc.xpath("//div[contains(@class,'profile-overview-stat-row')]//div[@class='col col-lg-3'][4]//div[@class='stat']/div[@class='value']/text()").first?.text
//            let top10l = doc.xpath("//div[contains(@class,'profile-overview-stat-row')]//div[@class='col col-lg-3'][4]//div[@class='stat']/div[@class='label']").first?.text
//            let wl = doc.xpath("//div[@class='label label-yellow']").first?.text
//
//            let wv = doc.xpath("//div[@class='col col-lg-3']//div[@class='value value-yellow']/text()").first?.text
//
//            let kv = doc.xpath("//div[contains(@class,'profile-overview-stat-row')]//div[@class='col col-lg-3'][3]//div[@class='stat']/div[@class='value']").first?.text
//            let kl = doc.xpath("//div[contains(@class,'profile-overview-stat-row')]//div[@class='col col-lg-3'][3]//div[@class='stat']/div[@class='label']").first?.text
//            top10countLabel.text = top10l?.uppercased()
//            top10countValue.text = top10rv
//            killsLabel.text = kl?.uppercased()
//            killsValue.text = kv
//            winsValue.text = wv
//            winsLabel.text = wl?.uppercased()
//            matchesPlayedLabel.text = mpl?.uppercased()
//            matchesPlayedValue.text = mpv
//            winRateLabel.text = wrl?.uppercased()
//            ratingLabel.text = rl?.uppercased()
//            kdLabel.text = kdl?.uppercased()
//            ratingValue.text = doc.xpath("//div[@class='value value-blue']").first?.text
//            winRateValue.text = doc.xpath("//div[@class='value value-green']").first?.text
//            kdValue.text = doc.xpath("//div[@class='value value-red']").first?.text
//            cellTitle.text = cellT?.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//            rankValue.text = rankV?.trimmingCharacters(in: .whitespacesAndNewlines)
//            rankLabel.text = rankL?.uppercased()
//
//
//            cellTitle.layer.masksToBounds = true
//            cellTitle.layer.cornerRadius = 5
//        }
//    }
    
}

