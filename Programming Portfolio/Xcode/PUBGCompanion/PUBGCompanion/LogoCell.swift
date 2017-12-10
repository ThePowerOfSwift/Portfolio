//
//  BattlegroundsLogoCell.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 30/08/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

class LogoCell: UICollectionViewCell {
 
    @IBOutlet weak var logoCellImage: UIImageView!
    
    func ConfigureCell(){
        logoCellImage.image = UIImage(named: "BATTLEGROUNDS_LOGO")
    }
    
}
