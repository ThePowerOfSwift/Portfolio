//
//  CustomView.swift
//  KellogsSocial
//
//  Created by Kel Robertson on 22/12/2016.
//  Copyright © 2016 Kel Robertson. All rights reserved.
//

import UIKit

class CustomView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 2.0
    }
    
    
    
}
