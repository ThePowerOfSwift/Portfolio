//
//  CompareCell.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 17/11/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

class CompareCell: UITableViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellValue: UILabel!
    @IBOutlet weak var cellShade: UILabel!

    var value = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func ConfigureCell(stat: Stats) {
        
    }
}
