//
//  LoadingView.swift
//  KChat
//
//  Created by Kel Robertson on 20/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    
    func showLoadingView(message: String, disableUI: Bool) {
        EZLoadingActivity.Settings.DarkensBackground = true
        EZLoadingActivity.Settings.FontName = "Avenir"
        EZLoadingActivity.Settings.BackgroundColor = UIColor.white
        EZLoadingActivity.Settings.ActivityColor = KCHAT_RED
        EZLoadingActivity.Settings.TextColor = KCHAT_RED
        EZLoadingActivity.show(message, disableUI: disableUI)
    }
    
    func hideLoadingViewLogin(success: Bool, animated: Bool) {
        EZLoadingActivity.Settings.FontName = "Avenir"
        EZLoadingActivity.Settings.DarkensBackground = false
        EZLoadingActivity.Settings.BackgroundColor = UIColor.white
        EZLoadingActivity.Settings.ActivityColor = KCHAT_RED
        EZLoadingActivity.Settings.TextColor = KCHAT_RED
        EZLoadingActivity.hide(success, animated: animated)
    }
    
    func hideLoadingViewBasic(animated: Bool) {
        EZLoadingActivity.Settings.FontName = "Avenir"
        EZLoadingActivity.Settings.DarkensBackground = false
        EZLoadingActivity.Settings.BackgroundColor = UIColor.white
        EZLoadingActivity.Settings.ActivityColor = KCHAT_RED
        EZLoadingActivity.Settings.TextColor = KCHAT_RED
        EZLoadingActivity.hide(animated: animated)
    }

}
