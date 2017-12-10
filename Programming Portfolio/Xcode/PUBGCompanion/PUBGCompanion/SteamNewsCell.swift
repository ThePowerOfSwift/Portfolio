//
//  SteamNewsCell.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 6/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import SwiftyJSON

class SteamNewsCell: UITableViewCell {
    
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var newsTitle: UILabel!

    func configureCell(_ data:[JSON]) {
        for x in 0..<data.count {
            newsTitle.text = data[x]["title"].stringValue
            dayLabel.text = Day(data[x]["date"].stringValue)
            monthLabel.text = Month(data[x]["date"].stringValue)
            yearLabel.text = Year(data[x]["date"].stringValue)
        }
        
    }

    func Day(_ date: String) -> String {
        let d = Date(timeIntervalSince1970: Double(date)!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let date = dateFormatter.string(from: d)
        return date
    }
    func Month(_ date: String) -> String {
        let d = Date(timeIntervalSince1970: Double(date)!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let date = dateFormatter.string(from: d)
        return date
    }
    func Year(_ date: String) -> String {
        let d = Date(timeIntervalSince1970: Double(date)!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let date = dateFormatter.string(from: d)
        return date
    }
    
}

class SteamAnnouncementCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    func configureCell(_ data:Steam) {
        titleLabel.text = data.title
        dayLabel.text = data.date.substring(to:data.date.index(data.date.startIndex, offsetBy: 2))
        monthLabel.text = data.date.substring(from:data.date.index(data.date.startIndex, offsetBy: 2)).replacingOccurrences(of: " ", with: "")
    }

}

