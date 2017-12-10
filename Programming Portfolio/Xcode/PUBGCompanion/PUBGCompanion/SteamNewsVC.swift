//
//  SteamNews.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 6/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kanna
import BTNavigationDropdownMenu
import NVActivityIndicatorView
import GoogleMobileAds

class SteamNewsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate{
    
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var titleLabel: UINavigationItem!
    @IBOutlet weak var scrapperWebview: UIWebView!
    @IBOutlet weak var adBanner: GADBannerView!
        @IBOutlet weak var adBannerHeight: NSLayoutConstraint!
    var SteamNews = [String: JSON]()
    var News = [JSON]()
    var steamAnnouncements = [Int:Steam]()
    
    var items = ["News", "Announcements"]
    
    var pageNumber:Int! = 0
    
    var activity: NVActivityIndicatorView!
    var menuView: BTNavigationDropdownMenu!
    
    @IBOutlet weak var noInternetView: UIView!
    @IBOutlet weak var noInternetYConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        checkIntenet()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidBecomeActive),
                                               name: .UIApplicationDidBecomeActive,
                                               object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self,
                                                  name: .UIApplicationDidBecomeActive,
                                                  object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    func LoadViewData(){
        adBanner.adUnitID = ADUNITID
        adBanner.rootViewController = self
        let request = GADRequest()
        //        request.testDevices = [ kGADSimulatorID,
        //                                TESTDEVICE ];
        
        adBanner.load(request)
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.width
        activity = NVActivityIndicatorView(frame: CGRect(x: screenWidth / 2 ,y: screenHeight / 2, width: 100 , height:100 ) , type: .ballScaleRippleMultiple, color: Y_ORANGE, padding: 10)
        self.view.addSubview(activity)
        activity.center.x = self.view.center.x
        activity.layer.cornerRadius = 50
        activity.backgroundColor = DARK_GREY
        activity.startAnimating()
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        scrapperWebview.delegate = self
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "News", items: items as [AnyObject])
        self.navigationItem.titleView = menuView
        
        SteamService.instance.GetSteamNews { (success, msg, data) in
            if (success)! {
                self.SteamNews = data
                self.ParseNewsData((self.SteamNews))
            }
        }
        
        menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
            switch indexPath {
            case 0:
                self?.pageNumber = 0
                SteamService.instance.GetSteamNews { (success, msg, data) in
                    if (success)! {
                        self?.SteamNews = data
                        self?.ParseNewsData((self?.SteamNews)!)
                        
                    }
                }
            case 1:
                self?.activity.startAnimating()
                    
                    let url = URLRequest(url: URL(string:"https://steamcommunity.com/app/578080/announcements/")!)
                    self?.scrapperWebview.loadRequest(url)
                
                DispatchQueue.main.async {
                    self?.pageNumber = 1
                    self?.newsTableView.reloadData()
                }
            default:
                break
            }
        }
    }
    
    func applicationDidBecomeActive() {
        checkIntenet()
    }
    
    func checkIntenet(){
        if currentReachabilityStatus != .notReachable
        {
            noInternetView.layer.cornerRadius = 5
            noInternetYConstraint.constant = -600
            UIView.animate(withDuration: 0.3) {
                super.view.layoutIfNeeded()
            }
            LoadViewData()
            menuView.isHidden = false

        }
        else
        {
            menuView.isHidden = true
            noInternetView.layer.cornerRadius = 5
            noInternetYConstraint.constant = 0
            UIView.animate(withDuration: 0.3) {
                super.view.layoutIfNeeded()
            }
            newsTableView.dataSource = nil
            newsTableView.delegate = nil
        }
    }
    
    

    func webViewDidFinishLoad(_ webView: UIWebView) {
        if let doc = scrapperWebview.stringByEvaluatingJavaScript(from: "document.documentElement.outerHTML") {
            parseHTML(doc)
        }
    }
    
    func parseHTML (_ html: String) -> Void {
        if let doc = HTML( html, encoding: String.Encoding.utf8) {
            var t = [String]()
            var d = [String]()
            var u = [String]()
            
            for title in doc.xpath("//div[@class='apphub_CardContentNewsTitle']") {
                t.append(title.innerHTML!)
            }
            for date in doc.xpath("//div[@class='apphub_CardContentNewsDate']") {
                d.append(date.innerHTML!)
            }
            for url in doc.xpath("//div[@class='apphub_Card Announcement_Card modalContentLink interactable']/@data-modal-content-url") {
                let dataSource = url.innerHTML!
                let strippedData = dataSource.replacingOccurrences(of: "data-modal-content-url=", with: "")
                let stripped = strippedData.replacingOccurrences(of: "\"", with: "")
                u.append(stripped)
            }
            
            for x in 0..<t.count {
                steamAnnouncements[x] = Steam(title: t[x], url: u[x], date: d[x])
            }
            self.newsTableView.reloadData()
            self.activity.stopAnimating()
        }
    }
    
    func ParseNewsData(_ data: [String:JSON]) {
        if let newsItems = data["appnews"]?["newsitems"].arrayValue {
            for news in newsItems {
                News.append(news)
            }
            self.newsTableView.reloadData()
            self.activity.stopAnimating()
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch pageNumber {
        case 0:
            let newItem = News[indexPath.row]
            if let cell = newsTableView.dequeueReusableCell(withIdentifier: "steamCell", for: indexPath) as? SteamNewsCell {
                cell.configureCell([newItem])
                return cell
            }
        case 1:
            let newItem = steamAnnouncements[indexPath.row]
            if let cell = newsTableView.dequeueReusableCell(withIdentifier: "steamAnnouncementCell", for: indexPath) as? SteamAnnouncementCell {
                cell.configureCell(newItem!)
                return cell
            }
            
        default:
            return UITableViewCell()
        }

        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch pageNumber {
        case 0:
            return News.count
        case 1:
            return steamAnnouncements.count
        default:
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch pageNumber {
        case 0:
            let newsItem = News[indexPath.row]
            performSegue(withIdentifier: "viewNews", sender: newsItem)
        case 1:
            let newsItem = steamAnnouncements[indexPath.row]
            performSegue(withIdentifier: "viewNews", sender: newsItem)
        default:
            break
        }
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? NewsViewVC {
            switch pageNumber {
            case 0:
                let jsonData = sender as? JSON
                destination.data = jsonData?["contents"].stringValue
                destination.ur = jsonData?["url"].stringValue
            case 1:
                let data = sender as? Steam
                destination.ur = data?.url
            default:
                break
            }
            
        }
    }
}


