//
//  ShareCell.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 7/10/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

class ShareCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var mod: UILabel!
    @IBOutlet weak var reg: UILabel!
    func ConfigureCell(data:ShareLinks){
        cellLabel.text = data.season!
        mod.text = data.mode!
        reg.text = data.region!
    }
}
