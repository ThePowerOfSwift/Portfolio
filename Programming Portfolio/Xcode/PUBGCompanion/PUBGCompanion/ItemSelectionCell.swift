//
//  ItemSelectionCell.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 10/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

class ItemSelectionCell: UICollectionViewCell {
    @IBOutlet weak var itemSelectionLabel: UILabel!
    func configureCell(itemType:String){
        itemSelectionLabel.text = itemType
    }
    
}
