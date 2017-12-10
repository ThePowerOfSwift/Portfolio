//
//  Custom View.swift
//  PenFriends
//
//  Created by Kel Robertson on 6/02/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
let SHADOW_GREY: CGFloat = 120.0 / 255.0

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
