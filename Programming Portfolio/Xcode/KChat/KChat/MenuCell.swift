//
//  MenuCells.swift
//  KChat
//
//  Created by Kel Robertson on 13/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    func configureCell(itemName: String, image: UIImage) {
        itemLabel.text = itemName
        itemImage.image = image
    }
}
