//
//  MatchHistoryHeader.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 21/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import LUExpandableTableView
import Kanna

class MatchHistoryHeader: LUExpandableTableViewSectionHeader{

    @IBOutlet weak var matchCount: UILabel!
    @IBOutlet weak var matchTime: UILabel!
    @IBOutlet weak var matchType: UILabel!
    @IBOutlet weak var matchRegion: UILabel!
    @IBOutlet weak var matchRating: UILabel!
    @IBOutlet weak var matchRatingLabel: UILabel!
    @IBOutlet weak var matchKills: UILabel!
    @IBOutlet weak var matchKillLabel: UILabel!
    @IBOutlet weak var expandCollapseButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        self.label.backgroundColor = UIColor.clear
        self.matchCount.textColor = Y_ORANGE
        matchRating.textColor = Y_ORANGE
    }
    
    func ConfigureCell(match: MatchHistoryMatch){
        self.matchCount.text = "\(match.mHRounds) Matches"
        self.matchTime.text = "\(PUBGTRACKER.instance.ReturnDateUpdated_NOz(date: match.mHLastUpdated)) Ago"
        self.matchKills.text = "\(match.mHKills)"
        self.matchRating.text = match.mHRating
        self.matchRegion.text = match.mhRegionDisplay
        self.matchKillLabel.text = "KILLS"
        self.matchRatingLabel.text = "RATING"
        if match.mHRatingChange > 0 {
            self.label.backgroundColor = GREEN
        } else if match.mHRatingChange < 0 {
            self.label.backgroundColor = RED
        }
    }
    
//    func ConfigureCell(data: String){
//        self.contentView.backgroundColor = DARK_GREY
//        if let doc = HTML(data, encoding: .utf8) {
//            for MC in doc.xpath("//div[@class='stat']/div[@class='value']"){
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
//                default:
//                    break
//                }
//                matchCount.text = MC.text!
//            }
//            for MT in doc.xpath("//div[@class='col match-header']/div[@class='match-time']") {
//                matchTime.text = MT.text!
//            }
//            for MR in doc.xpath("//div[@class='col text-uppercase match-icons']//div//span[1]"){
//                matchRegion.text = MR.text!.uppercased()
//            }
//            for MR in doc.xpath("//div[@class='row']/div[@class='col'][1]/div[contains(@class,'stat')]/div[contains(@class,'value')]"){
//                matchRating.text = MR.text!
//                if (MR.text?.contains("-"))!{
//                    label.backgroundColor = RED
//                    matchRating.textColor = RED
//                } else if (MR.text?.contains("+"))! {
//                    matchRating.textColor = GREEN
//                }
//            }
//            for MRL in doc.xpath("//div[@class='row']/div[@class='col'][1]//div[2]"){
//                matchRatingLabel.text = MRL.text?.uppercased()
//            }
//            for K in doc.xpath("//div[@class='col'][2]/div[@class='stat']/div[@class='value']") {
//                matchKills.text = K.text
//            }
//            for KL in doc.xpath("//div[@class='col'][2]/div[@class='stat']/div[@class='label']") {
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
//        }
//    }

    
    override var isExpanded: Bool {
        didSet {
            // Change the title of the button when section header expand/collapse
            expandCollapseButton?.setTitle(isExpanded ? "↑" : "↓", for: .normal)
        }
    }
    
    // MARK: - Base Class Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnLabel)))
        label?.isUserInteractionEnabled = true
    }
    
    // MARK: - IBActions
    
    @IBAction func expandCollapse(_ sender: UIButton) {
        // Send the message to his delegate that shold expand or collapse
        delegate?.expandableSectionHeader(self, shouldExpandOrCollapseAtSection: section)
    }
    
    // MARK: - Private Functions
    
    @objc private func didTapOnLabel(_ sender: UIGestureRecognizer) {
        // Send the message to his delegate that was selected
        delegate?.expandableSectionHeader(self, wasSelectedAtSection: section)
    }
}
