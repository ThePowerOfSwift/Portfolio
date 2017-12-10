//
//  RoundedButton.swift
//  KChat
//
//  Created by Kel Robertson on 7/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var cornerRadis: CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadis
            layer.masksToBounds = cornerRadis > 0
            
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet{
            layer.borderColor = borderColor?.cgColor
        }
    }
    @IBInspectable var bgColor: UIColor? {
        didSet {
            backgroundColor = bgColor
        }
    }

}
