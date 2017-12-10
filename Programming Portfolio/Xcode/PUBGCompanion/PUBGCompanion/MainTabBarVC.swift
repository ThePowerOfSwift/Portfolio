//
//  MainTabBarVC.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 30/08/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import RevealingSplashView

class MainTabBarVC: UITabBarController,UICollectionViewDelegate{
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialize a revealing Splash with with the iconImage, the initial size and the background color
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "PUBGHUB_LOGO")!,iconInitialSize: CGSize(width: 240, height: 128), backgroundColor: DARK_GREY)
        
        //Adds the revealing splash view as a sub view
        self.view.addSubview(revealingSplashView)
        
        //Starts animation
        revealingSplashView.startAnimation(){
        }

        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self,
                                                  name: .UIApplicationDidBecomeActive,
                                                  object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CheckInternet()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidBecomeActive),
                                               name: .UIApplicationDidBecomeActive,
                                               object: nil)
        
        
    }
    func applicationDidBecomeActive() {
        CheckInternet()
    }
    func CheckInternet() {
        if currentReachabilityStatus != .notReachable
        {

            if  let arrayOfTabBarItems = self.tabBar.items as? AnyObject as? NSArray,let tabBarItem1 = arrayOfTabBarItems[0] as? UITabBarItem,let tabBarItem2 = arrayOfTabBarItems[1] as? UITabBarItem,let tabBarItem3 = arrayOfTabBarItems[2] as? UITabBarItem {
                tabBarItem1.isEnabled = true
                tabBarItem2.isEnabled = true
                tabBarItem3.isEnabled = true

            }
        }
        else
        {
            if  let arrayOfTabBarItems = self.tabBar.items as? AnyObject as? NSArray,let tabBarItem1 = arrayOfTabBarItems[0] as? UITabBarItem,let tabBarItem2 = arrayOfTabBarItems[1] as? UITabBarItem,let tabBarItem3 = arrayOfTabBarItems[2] as? UITabBarItem{
                tabBarItem1.isEnabled = false
                tabBarItem2.isEnabled = false
                tabBarItem3.isEnabled = false
            }
        }
    }
}
