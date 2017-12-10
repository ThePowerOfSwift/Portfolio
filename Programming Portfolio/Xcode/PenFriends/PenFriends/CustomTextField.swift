//
//  CustomTextField.swift
//  PenFriends
//
//  Created by Kel Robertson on 5/02/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
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
    @IBInspectable var placeHolderColor: UIColor? {
        didSet {
            let rawString = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string : ""
            let str = NSAttributedString(string: rawString, attributes: [NSForegroundColorAttributeName: placeHolderColor!])
            attributedPlaceholder = str
        }
    }
}

