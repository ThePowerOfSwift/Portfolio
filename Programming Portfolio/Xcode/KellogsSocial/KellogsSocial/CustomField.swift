//
//  CustomField.swift
//  KellogsSocial
//
//  Created by Kel Robertson on 22/12/2016.
//  Copyright © 2016 Kel Robertson. All rights reserved.
//

import UIKit

class CustomField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.2).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 2.0
        
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10.0, dy: 5.0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10.0, dy: 5.0)
    }

}
