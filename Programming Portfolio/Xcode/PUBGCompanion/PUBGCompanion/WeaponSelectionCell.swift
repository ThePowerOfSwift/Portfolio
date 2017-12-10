//
//  WeaponSelectionCell.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 9/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

class WeaponSelectionCell: UICollectionViewCell {
    @IBOutlet weak var weaponSelectionLabel: UILabel!
    func configureCell(weaponType:String){
        weaponSelectionLabel.text = weaponType
    }
    
}
