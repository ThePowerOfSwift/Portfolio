//
//  YoutubeVideosVC.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 1/10/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import GoogleMobileAds
import NVActivityIndicatorView
import BTNavigationDropdownMenu
import Alamofire
import SwiftyJSON

class YoutubeVideosVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    @IBOutlet weak var adBanner: GADBannerView!
    @IBOutlet weak var adBannerHeight: NSLayoutConstraint!
    @IBOutlet weak var noInternetView: UIView!
    @IBOutlet weak var noInternetYConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoLabel: UILabel!
    
    var activity: NVActivityIndicatorView!
    var searchBar = UISearchBar()
    var youtubeVideos = [JSON]()
    var pageNumber: Int! = 1
    var currentQ:String!
    var nPageT: String!
    var pPageT: String!
    
    var tap: UIGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if youtubeVideos.count > 1 {
            infoLabel.isHidden = true
        } else {
            infoLabel.isHidden = false
        }
        searchBar.sizeToFit()
        searchBar.placeholder = "Search Youtube"
        searchBar.delegate = self
        searchBar.barStyle = .blackTranslucent
        searchBar.barTintColor = DARK_GREY
        searchView.addSubview(searchBar)
        searchBar.tintColor = Y_ORANGE
        searchView.tintColor = DARK_GREY
        checkIntenet()
        NotificationCenter.default.addObserver(self,selector: #selector(applicationDidBecomeActive),name: .UIApplicationDidBecomeActive,                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self,name: .UIApplicationDidBecomeActive, object: nil)
    }
    
    func applicationDidBecomeActive() {
        checkIntenet()
    }
    
    func checkIntenet(){
        if currentReachabilityStatus != .notReachable {
            noInternetView.layer.cornerRadius = 5
            noInternetYConstraint.constant = -600
            UIView.animate(withDuration: 0.3) {
                super.view.layoutIfNeeded()
                
            }
            videoCollectionView.alpha = 1
            LoadViewData()
        } else {
            noInternetView.layer.cornerRadius = 5
            noInternetYConstraint.constant = 0
            UIView.animate(withDuration: 0.3) {
                super.view.layoutIfNeeded()
                
            }
            videoCollectionView.alpha = 0
        }
    }
    
    func LoadViewData(){
        adBanner.adUnitID = ADUNITID
        adBanner.rootViewController = self
        let request = GADRequest()
        adBanner.load(request)
        videoCollectionView.delegate = self
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
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tap = UITapGestureRecognizer(target: self, action: #selector(YoutubeVideosVC.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.view.removeGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        self.searchView.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        LoadActivity()
        infoLabel.isHidden = true
        dismissKeyboard()
        self.videoCollectionView.delegate = nil
        self.videoCollectionView.dataSource = nil
        youtubeVideos.removeAll()
        if let query = searchBar.text {
            currentQ = query
            Alamofire.request("https://www.googleapis.com/youtube/v3/search", method: .get, parameters: ["part" : "snippet" , "q" : query , "key" : YOUTUBEKEY, "relevanceLanguage": "en"], encoding: URLEncoding.default, headers: nil).responseJSON{(response) -> Void in
                
                let data = JSON(response.result.value!)
                for item in data["items"].arrayValue {
                    self.youtubeVideos.append(item)
                }
                if let npt = data["nextPageToken"].string {
                    self.nPageT = npt
                }
                if let ppt = data["prevPageToken"].string {
                    self.pPageT = ppt
                }
                DispatchQueue.main.async {
                    self.videoCollectionView.delegate = self
                    self.videoCollectionView.dataSource = self
                    self.activity.stopAnimating()
                    
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 5:
            if let nextCell = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "nextCell", for: indexPath) as? NextPageCell{
                nextCell.nextLabel.text = "Next"
                nextCell.layer.cornerRadius = 5
                return nextCell
            }
            break
        case 6:
            if let previousCell = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "previousCell", for: indexPath) as? PreviousPageCell{
                previousCell.previousLabel.text = "Previous"
                previousCell.layer.cornerRadius = 5
                return previousCell
            }
            break
        default:
            if let videoCell = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "videoResultCell", for: indexPath) as? VideoResultCell {
                let video = youtubeVideos[indexPath.row]
                videoCell.ConfigureYouTubeCell(video)
                
                videoCell.layer.cornerRadius = 5
                return videoCell
            }
            
        }
        return UICollectionViewCell()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if pageNumber == 1 {
            return 6
        } else {
            return 7
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        switch indexPath.row {
        case 5:
            return CGSize(width: 265.0, height: 40.0)
        case 6:
            return CGSize(width: 265.0, height: 40.0)
        default:
            return CGSize(width: (collectionView.bounds.width - 20), height: 100.0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 5:
            self.activity.startAnimating()
            youtubeVideos.removeAll()
            pageNumber = pageNumber + 1
            Alamofire.request("https://www.googleapis.com/youtube/v3/search", method: .get, parameters: ["part" : "snippet" , "q" : currentQ , "key" : YOUTUBEKEY, "pageToken": nPageT, "relevanceLanguage": "en"], encoding: URLEncoding.default, headers: nil).responseJSON{(response) -> Void in
                let data = JSON(response.result.value!)
                for item in data["items"].arrayValue {
                    self.youtubeVideos.append(item)
                }
                if let npt = data["nextPageToken"].string {
                    self.nPageT = npt
                }
                if let ppt = data["prevPageToken"].string {
                    self.pPageT = ppt
                }
                DispatchQueue.main.async {

                    self.videoCollectionView.reloadData()
                    self.activity.stopAnimating()
                    self.videoCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),at: .top,animated: true)
                }
            }
            
            
        case 6:
            self.activity.startAnimating()
            youtubeVideos.removeAll()
            pageNumber = pageNumber - 1
            Alamofire.request("https://www.googleapis.com/youtube/v3/search", method: .get, parameters: ["part" : "snippet" , "q" : currentQ , "key" : YOUTUBEKEY, "pageToken": pPageT, "relevanceLanguage": "en"], encoding: URLEncoding.default, headers: nil).responseJSON{(response) -> Void in
                let data = JSON(response.result.value!)
                
                for item in data["items"].arrayValue {
                    self.youtubeVideos.append(item)
                }
                if let npt = data["nextPageToken"].string {
                    self.nPageT = npt
                }
                if let ppt = data["prevPageToken"].string {
                    self.pPageT = ppt
                }
                DispatchQueue.main.async {
                    self.videoCollectionView.reloadData()
                    self.activity.stopAnimating()
                    self.videoCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),at: .top,animated: true)
                }
            }
            
            
        default:
            performSegue(withIdentifier: "showVideo", sender: youtubeVideos[indexPath.row]["id"]["videoId"].stringValue)
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVideo" {
            if let destionation = segue.destination as? ViewVideoVC {
                destionation.videoID = sender as! String
            }
        }
    }
}
