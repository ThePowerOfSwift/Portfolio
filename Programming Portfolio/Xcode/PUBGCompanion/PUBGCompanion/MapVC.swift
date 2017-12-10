//
//  MapVC.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 9/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu
import NVActivityIndicatorView

class MapVC: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var mapWebView: UIWebView!
    
    var maps = ["Erangle"]
    var mapURLs = MAP_URLS
    
    var activity: NVActivityIndicatorView!
    var menuView: BTNavigationDropdownMenu!
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadActivity()
        loadWebData(u: mapURLs[0])
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "Erangle", items: maps as [AnyObject])
        self.navigationItem.titleView = menuView
        menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
            self?.loadWebData(u: (self?.mapURLs[indexPath])!)
            self?.LoadActivity()
        }
        
        mapWebView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        menuView.hide()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activity.stopAnimating()
    }

    func loadWebData(u:String){
        let url = URL(string: u)
        var urlRequest = URLRequest(url: url!)
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        mapWebView.loadRequest(urlRequest)
    }
    func LoadActivity(){
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.width
        activity = NVActivityIndicatorView(frame: CGRect(x: screenWidth / 2 ,y: screenHeight / 2, width: 100 , height:100 ) , type: .ballScaleRippleMultiple, color: Y_ORANGE, padding: 10)
        self.view.addSubview(activity)
        activity.center.x = self.view.center.x
        activity.layer.cornerRadius = 50
        activity.backgroundColor = DARK_GREY
        activity.startAnimating()
    }
}
