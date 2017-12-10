//
//  VideoPageVC.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 3/10/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class VideoPageVC: TabmanViewController, PageboyViewControllerDataSource {
    
    lazy var ViewControllers: [UIViewController] = {
        return [self.VCInstnace("SteamVideos"), self.VCInstnace("SteamArtwork"),self.VCInstnace("YoutubeVideos")]
    }()
    
    fileprivate func VCInstnace(_ name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        reloadPages()
       self.automaticallyAdjustsChildScrollViewInsets = false
    }
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        self.parentPageboyViewController?.scrollToPage(.first, animated: false)
        self.bar.items = [TabmanBar.Item(title: "Videos"),
                          TabmanBar.Item(title: "Artwork"),
                          TabmanBar.Item(title: "Search")]
        self.bar.style = .blockTabBar
        self.bar.appearance = TabmanBar.Appearance({ (appearance) in
            appearance.style.background = .blur(style: .dark)
            appearance.state.color = Y_ORANGE
            appearance.state.selectedColor = BLUE
            appearance.indicator.color = DARK_GREY
            appearance.indicator.useRoundedCorners = true
            appearance.text.font = UIFont(name: "Staubach", size: 16)
        })
        
        return ViewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return ViewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .first
    }
}
