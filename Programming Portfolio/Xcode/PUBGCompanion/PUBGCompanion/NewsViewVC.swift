//
//  NewsViewVC.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 6/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import NVActivityIndicatorView

class NewsViewVC: UIViewController, UIWebViewDelegate {

    var data: String!
    var ur: String!
    var activity: NVActivityIndicatorView!
    
    @IBOutlet weak var newsWebView: UIWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsWebView.backgroundColor = LIGHT_GREY
        
        LoadActivity()
        
        let u = URL(string:ur.replacingOccurrences(of: " ", with: ""))
        var url = URLRequest(url:u!)
        url.cachePolicy = .returnCacheDataElseLoad
        newsWebView.loadRequest(url)
        newsWebView.delegate = self
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activity.stopAnimating()
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
