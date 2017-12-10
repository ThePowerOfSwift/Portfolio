//
//  ViewController.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 27/08/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Kanna
import NVActivityIndicatorView
import GoogleMobileAds

class VideosVC: UIViewController,UIWebViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var webViewer: UIWebView!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    @IBOutlet weak var adBanner: GADBannerView!
    @IBOutlet weak var adBannerHeight: NSLayoutConstraint!
    
    var battlegroundVideos = [Int:SteamVideos]()
    var steamVideoTitle = [String]()
    var steamVideoSrc = [String]()
    var steamVideoPreviewImageSrc = [String]()
    var steamCommentCount = [String]()
    var steamRating = [String?](repeating: nil, count:4)
    var steamAuthor = [String]()
    
    var pageInt:Int = 1
    var pageNumber:Int = 5
    
    var filter = ["trendweek","trendday", "toprated"]
    var items = ["Popular This Week", "Popular Today", "Popular All Time"]
    var videoFilter:String!
    
    var activity: NVActivityIndicatorView!
    
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
        
        adBanner.load(request)
        
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.width
        activity = NVActivityIndicatorView(frame: CGRect(x: screenWidth / 2 ,y: screenHeight / 2, width: 100 , height:100 ) , type: .ballScaleRippleMultiple, color: Y_ORANGE, padding: 10)
        self.view.addSubview(activity)
        activity.center.x = self.view.center.x
        activity.layer.cornerRadius = 50
        activity.backgroundColor = DARK_GREY
        activity.startAnimating()

        webViewer.delegate = self
        videoCollectionView.delegate = self
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
            videoFilter = filter[0]
            ScrapeWebData(pageInt, itemPerPage: pageNumber, filter: videoFilter)
            LoadViewData()
            videoCollectionView.alpha = 1
        }
        else
        {
            noInternetView.layer.cornerRadius = 5
            noInternetYConstraint.constant = 0
            UIView.animate(withDuration: 0.3) {
                super.view.layoutIfNeeded()
            }
            videoCollectionView.alpha = 0
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if let doc = webViewer.stringByEvaluatingJavaScript(from: "document.documentElement.outerHTML") {
            parseHTML(doc)
        }
        self.videoCollectionView.reloadData()
    }
    
    func parseHTML(_ html: String) -> Void {
        steamRating.removeAll()
        steamAuthor.removeAll()
        steamCommentCount.removeAll()
        steamVideoSrc.removeAll()
        steamVideoTitle.removeAll()
        steamVideoPreviewImageSrc.removeAll()
        if let doc = Kanna.HTML(html, encoding: String.Encoding.utf8) {
            for title in doc.css("div[class^=apphub_CardContentTitle ellipsis]") {
                steamVideoTitle.append(title.innerHTML!)
            }
            
            
            for data in doc.xpath("//div[@class='apphub_Card modalContentLink interactable']/@data-modal-content-url"){
                let dataSource = data.innerHTML!
                let strippedData = dataSource.replacingOccurrences(of: "data-modal-content-url=", with: "")
                steamVideoSrc.append(strippedData)
            }
            
            for imgSrc in doc.xpath("//img[@class='apphub_CardContentPreviewImage']/@src"){
                let dataSource = imgSrc.innerHTML!
                let strippedData = dataSource.replacingOccurrences(of: "src=", with: "")
                let finalData = strippedData.replacingOccurrences(of: "\"", with: "")
                let final = finalData.replacingOccurrences(of: " ", with: "")
                steamVideoPreviewImageSrc.append(final)
            }
            for comment in doc.css("div[class='apphub_CardCommentCount']"){
                steamCommentCount.append(comment.text!)
            }
            for rating in doc.css("div[class='apphub_CardRating rateUp']"){
                let ratingText = rating.text!
                let trimmedRatings = ratingText.trimmingCharacters(in: .whitespacesAndNewlines)
                steamRating.append(trimmedRatings)
            }
            for author in doc.xpath("//div[@class='apphub_friend_block']/div/a"){
                if (author.innerHTML == "" || author.innerHTML == "View videos"){
                }else {
                    steamAuthor.append(author.innerHTML!)
                }
            }
            
            
            createDictionary(steamVideoTitle, src: steamVideoSrc, ImgSrc: steamVideoPreviewImageSrc, CommentCount: steamCommentCount, RatingCount: steamRating, author: steamAuthor)
        }
    }
    
    func createDictionary(_ title: [String], src: [String], ImgSrc: [String], CommentCount:[String], RatingCount:[String?] , author: [String]){
        battlegroundVideos.removeAll()
        
        for x in 0..<steamVideoTitle.count {
            if (videoFilter != "mostrecent") {
                battlegroundVideos[x] = SteamVideos(Title: steamVideoTitle[x] , Source: steamVideoSrc[x], ImgSrc: steamVideoPreviewImageSrc[x], CommentCount: steamCommentCount[x], RatingCount: RatingCount[x]!, Author: steamAuthor[x])
            } else {
                battlegroundVideos[x] = SteamVideos(Title: steamVideoTitle[x] , Source: steamVideoSrc[x], ImgSrc: steamVideoPreviewImageSrc[x], CommentCount: steamCommentCount[x], RatingCount: "", Author: steamAuthor[x])
            }
        }
        videoCollectionView.dataSource = self
        activity.stopAnimating()
    }
    
    func ScrapeWebData(_ pageNumber:Int,itemPerPage:Int,filter: String){
        let url = URL (string: "https://steamcommunity.com/app/578080/homecontent/?userreviewsoffset=0&p=\(pageNumber)&workshopitemspage=\(pageNumber)&readytouseitemspage=\(pageNumber)&mtxitemspage=2&itemspage=\(pageNumber)&screenshotspage=\(pageNumber)&videospage=\(pageNumber)&artpage=\(pageNumber)&allguidepage=\(pageNumber)&webguidepage=\(pageNumber)&integratedguidepage=\(pageNumber)&discussionspage=\(pageNumber)&numperpage=\(itemPerPage)&browsefilter=\(filter)&l=english&appHubSubSection=3&filterLanguage=default&searchText=&forceanon=1")
        
        
        let requestObj = URLRequest(url: url! as URL)
        webViewer.loadRequest(requestObj as URLRequest)
        
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
                if (videoFilter == "mostrecent"){
                    videoCell.ConfigureCellHiddenHeart(battlegroundVideos, indexP: indexPath.row)
                }else{
                    videoCell.ConfigureCell(battlegroundVideos, indexP: indexPath.row)
                }
                
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
        if pageInt == 1 {
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
            pageInt = pageInt + 1
            ScrapeWebData(pageInt, itemPerPage: pageNumber, filter: self.videoFilter)
            self.activity.startAnimating()
            self.videoCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),                                                      at: .top,                                                      animated: true)
                self.videoCollectionView.dataSource = nil
        case 6:
            pageInt = pageInt - 1
            ScrapeWebData(pageInt, itemPerPage: pageNumber, filter: self.videoFilter)
            self.activity.startAnimating()
            self.videoCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),                                                      at: .top,                                                      animated: true)
                self.videoCollectionView.dataSource = nil
        default:
            performSegue(withIdentifier: "showVideo", sender: battlegroundVideos[indexPath.row]?.ImgSrc)
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let string = sender as? String {
            let removeImg = string.replacingOccurrences(of: "img", with: "www")
            let removeEnd = removeImg.replacingOccurrences(of: "/0.jpg", with: "")
            let embed = removeEnd.replacingOccurrences(of: "vi/", with: "watch?v=")
            let videoID = embed.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: "")
            if segue.identifier == "showVideo" {
                let destinationVideo = segue.destination as! ViewVideoVC
                    destinationVideo.videoID = videoID
            }
        }
        
        
    }
}

