//
//  MainMenuCell.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 30/08/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

class MainMenuCell: UICollectionViewCell {
    
    @IBOutlet weak var sectionImg: UIImageView!
    @IBOutlet weak var sectionTitle: UILabel!
    
    func ConfigureCell(_ title:String, img:String){
        sectionImg.image = UIImage(named: img)
        sectionTitle.text = title
    }
}
