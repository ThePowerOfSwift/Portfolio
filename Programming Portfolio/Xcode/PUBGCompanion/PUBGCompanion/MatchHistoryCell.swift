//
//  MatchHistoryCell.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 22/10/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Kanna

class MatchHistoryCell: UITableViewCell {
    
    @IBOutlet weak var matchCount: UILabel!
    @IBOutlet weak var matchTime: UILabel!
    @IBOutlet weak var matchType: UILabel!
    @IBOutlet weak var matchRegion: UILabel!
    @IBOutlet weak var matchRating: UILabel!
    @IBOutlet weak var matchRatingLabel: UILabel!
    @IBOutlet weak var matchKills: UILabel!
    @IBOutlet weak var matchKillLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    
    var extraData:Bool! = false

    override func awakeFromNib() {
        super.awakeFromNib()
        extraData = false
        label.backgroundColor = UIColor.clear
        matchCount.textColor = Y_ORANGE
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        self.label.backgroundColor = UIColor.clear
        self.matchCount.textColor = Y_ORANGE
        matchRating.textColor = Y_ORANGE
        extraData = false
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func ConfigureCell(match: MatchHistoryMatch){
        self.matchCount.text = match.mHRounds

        self.matchTime.text = PUBGTRACKER.instance.ReturnDateUpdated_NOz(date: match.mHLastUpdated)
        self.matchKills.text = "\(match.mHKills)"
        self.matchRating.text = match.mHRating
        self.matchRegion.text = match.mhRegionDisplay
        self.matchKillLabel.text = "KILLS"
        self.matchRatingLabel.text = "RATING"
        
    }
//    func ConfigureCell(data:String){
//        if let doc = HTML(data, encoding: .utf8) {
//            for MC in doc.xpath("//div[@class='row']/div[@class='col match-row-result stat-result']/div[@class='stat']/div[@class='value']"){
//                let txt = MC.text?.trimmingCharacters(in: .whitespacesAndNewlines)
//                switch  txt! {
//                case "Top 10":
//                    self.label.backgroundColor = BLUE
//                    self.matchCount.textColor = BLUE
//                    break
//                case "Win":
//                    self.label.backgroundColor = GREEN
//                    self.matchCount.textColor = GREEN
//                    break
//                case "Died":
//                    self.label.backgroundColor = RED
//                    self.matchCount.textColor = RED
//                default:
//                    break
//                }
//                matchCount.text = MC.text!
//            }
//            for MT in doc.xpath("//div[@class='row']/div[@class='col match-row-result stat-result']/div[@class='stat']/div[@class='label']") {
//                matchTime.text = MT.text!
//            }
//            for MR in doc.xpath("//div[@class='row']/div[@class='col match-row-mode']/div[@class='stat']/div[@class='value']/span[1]"){
//                matchRegion.text = MR.text!.uppercased()
//            }
//            for MR in doc.xpath("//div[@class='row']/div[@class='col'][1]/div[@class='stat']/div[@class='value']/span[@class='value-new']"){
//                matchRating.text = MR.text!
//            }
//            for MRL in doc.xpath("//div[@class='row']/div[@class='col'][1]//div[2]"){
//                matchRatingLabel.text = MRL.text?.uppercased()
//            }
//            for K in doc.xpath("//div[@class='row']/div[@class='col match-row-small-stat'][1]/div[@class='stat']/div[@class='value']") {
//                matchKills.text = K.text
//            }
//            for KL in doc.xpath("//div[@class='row']/div[@class='col match-row-small-stat'][1]/div[@class='stat']/div[@class='label']") {
//                matchKillLabel.text = KL.text?.uppercased()
//            }
//            for MTP in doc.xpath("//div/@title") {
//                let txt = MTP.text!
//                let rangeL = txt.range(of: "(")
//                let uStr = txt.substring(to: (rangeL?.lowerBound)!)
//                let rangeU = txt.range(of: "-")
//                let lStr = uStr.substring(from: (rangeU?.upperBound)!)
//                let finalStr = lStr.replacingOccurrences(of: " ", with: "")
//                matchType.text = finalStr
//            }
//            if let _ = doc.xpath("//i[@class='zmdi zmdi-chevron-right']").first {
//                extraData = true
//            }
//
//        }
//    }
    

}
