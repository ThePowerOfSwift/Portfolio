//
//  tabmantest.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 3/10/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class ArtworkPageVC: TabmanViewController, PageboyViewControllerDataSource {

    lazy var ViewControllers: [UIViewController] = {
        return []
    }()
    
    fileprivate func VCInstnace(_ name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.bar.items = [TabmanBar.Item(title: "Game"),TabmanBar.Item(title: "Tips & Tricks"),TabmanBar.Item(title: "Weekly Crate")]
        self.bar.style = .blockTabBar
        self.bar.appearance = TabmanBar.Appearance({ (appearance) in
            appearance.style.background = .blur(style: .dark)
            appearance.state.color = Y_ORANGE
            appearance.state.selectedColor = Y_ORANGE
            appearance.indicator.color = DARK_GREY
            appearance.indicator.useRoundedCorners = true
            appearance.text.font = UIFont(name: "Staubach", size: 16)
        })

    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {

        return ViewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return ViewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
