//
//  NotificationView.swift
//  KChat
//
//  Created by Kel Robertson on 20/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func NotificationBanner(title: String, message: String) {
        let banner = Banner(title: title, subtitle: message)
        banner.backgroundColor = UIColor.white
        banner.dismissesOnTap = true
        banner.titleLabel.textColor = UIColor(hue: 0.06, saturation: 0.84, brightness: 0.69, alpha: 1.0)
        banner.titleLabel.font = UIFont(name: "Avenir", size: 16.0)
        banner.titleLabel.textAlignment = NSTextAlignment.center
        banner.detailLabel.textColor = UIColor(hue: 0.06, saturation: 0.84, brightness: 0.69, alpha: 1.0)
        banner.detailLabel.font = UIFont(name: "Avenir", size: 12.0)
        banner.detailLabel.textAlignment = NSTextAlignment.center
        banner.show(duration: 2.0)
    }
}
