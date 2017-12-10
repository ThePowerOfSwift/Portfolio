//
//  ArtworkVC.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 14/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Kanna
import NVActivityIndicatorView
import GoogleMobileAds
import Alamofire

class ArtworkVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var videoCollectionView: UICollectionView!
    @IBOutlet weak var adBanner: GADBannerView!
    @IBOutlet weak var adBannerHeight: NSLayoutConstraint!
    
    var battlegroundVideos = [Int:SteamArtwork]()
    var steamVideoTitle = [String]()
    var steamVideoSrc = [String]()
    var steamVideoHeight = [String]()
    var steamVideoPreviewImageSrc = [String]()
    var steamCommentCount = [String]()
    var steamRating = [String?](repeating: nil, count:4)
    var steamAuthor = [String]()
    
    var pageInt:Int = 1
    var pageNumber:Int = 4
    
    var filter = ["trendweek","trendday", "toprated"]
    var items = ["Popular This Week", "Popular Today", "Popular All Time"]
    var videoFilter:String!
    var cellCount:Int! = 0
    
    static var cellImageCache: NSCache<NSString, UIImage> = NSCache()
    
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
        videoCollectionView.delegate = self
    }
    
    func parseHTML(_ html: String) -> Void {
        steamRating.removeAll()
        steamAuthor.removeAll()
        steamCommentCount.removeAll()
        steamVideoSrc.removeAll()
        steamVideoTitle.removeAll()
        steamVideoPreviewImageSrc.removeAll()
        steamVideoHeight.removeAll()
        if let doc = Kanna.HTML(html, encoding: String.Encoding.utf8) {
            for title in doc.xpath("//div[@class='apphub_CardContentTitle ellipsis']"){
                steamVideoTitle.append(title.text!)
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
            for imgHeight in doc.xpath("//img[@class='apphub_CardContentPreviewImage']/@height") {
                let dataSource = imgHeight.innerHTML!
                let strippedData = dataSource.replacingOccurrences(of: "height=", with: "")
                let finalData = strippedData.replacingOccurrences(of: "\"", with: "")
                let final = finalData.replacingOccurrences(of: " ", with: "")
                steamVideoHeight.append(final)
            }
            for comment in doc.xpath("//div[@class='apphub_CardCommentCount']"){
                steamCommentCount.append(comment.text!)
            }
            for rating in doc.xpath("//div[@class='apphub_CardRating rateUp withRateButtons']"){
                let ratingText = rating.text!
                let trimmedRatings = ratingText.trimmingCharacters(in: .whitespacesAndNewlines)
                steamRating.append(trimmedRatings)
            }
            for author in doc.xpath("//div[contains(@class,'apphub_CardContentAuthorName')]"){
                steamAuthor.append(author.text!)
            }
            
            
            createDictionary(steamVideoTitle, src: steamVideoSrc, ImgSrc: steamVideoPreviewImageSrc, CommentCount: steamCommentCount, RatingCount: steamRating, author: steamAuthor, cellHeight: steamVideoHeight)
        }
    }
    
    func createDictionary(_ title: [String], src: [String], ImgSrc: [String], CommentCount:[String], RatingCount:[String?] , author: [String], cellHeight: [String]){
        battlegroundVideos.removeAll()
        for x in 0..<steamVideoTitle.count {
            if (videoFilter != "mostrecent") {
                
                battlegroundVideos[x] = SteamArtwork(Title: steamVideoTitle[x] , Source: steamVideoSrc[x], ImgSrc: steamVideoPreviewImageSrc[x], CommentCount: steamCommentCount[x], RatingCount: RatingCount[x]!, Author: steamAuthor[x], cellHeight: steamVideoHeight[x])
            } else {
                battlegroundVideos[x] = SteamArtwork(Title: steamVideoTitle[x] , Source: steamVideoSrc[x], ImgSrc: steamVideoPreviewImageSrc[x], CommentCount: steamCommentCount[x], RatingCount: "", Author: steamAuthor[x], cellHeight: steamVideoHeight[x])
            }
        }
        self.videoCollectionView.dataSource = self
        self.videoCollectionView.reloadData()
        DispatchQueue.main.async {
            
            self.activity.stopAnimating()
        }
        
    }
    
    func ScrapeWebData(_ pageNumber:Int,itemPerPage:Int,filter: String){
        Alamofire.request(URL(string:"https://steamcommunity.com/app/578080/homecontent/?userreviewsoffset=0&p=\(pageNumber)&artpage=\(pageNumber)&numperpage=\(itemPerPage)&browsefilter=\(filter)&l=english&appHubSubSection=4&filterLanguage=default&searchText=&forceanon=1")!).responseString(encoding: String.Encoding.utf8) { (htmlData) in

                self.parseHTML(htmlData.result.value!)
            
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
            videoFilter = filter[0]
            self.ScrapeWebData(self.pageInt, itemPerPage: self.pageNumber, filter: self.videoFilter)
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 4:
            if let nextCell = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "nextCell", for: indexPath) as? NextPageCell{
                nextCell.nextLabel.text = "Next"
                nextCell.layer.cornerRadius = 5
                return nextCell
            }
            break
        case 5:
            if let previousCell = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "previousCell", for: indexPath) as? PreviousPageCell{
                previousCell.previousLabel.text = "Previous"
                previousCell.layer.cornerRadius = 5
                return previousCell
            }
            break
        default:
            if let artworkCell = videoCollectionView.dequeueReusableCell(withReuseIdentifier: "artworkCell", for: indexPath) as? ArtworkResultsCell {
                if (videoFilter == "mostrecent"){
                    artworkCell.ConfigureCellHiddenHeartArt(battlegroundVideos, indexP: indexPath.row)
                }else{
                    artworkCell.ConfigureCellArt(battlegroundVideos, indexP: indexPath.row)
                }
                if artworkCell.activity.isAnimating && artworkCell.gifImageSrc.image != nil {
                    artworkCell.activity.stopAnimating()
                }
                return artworkCell
            }
            
        }
        return UICollectionViewCell()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if pageInt == 1 {
            return 5
        } else {
            return 6
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cell = battlegroundVideos[indexPath.row]
        var height: CGFloat!
        if let cellH = cell?.cellHeight {
            let h = CGFloat((cellH as NSString).doubleValue)
            height = h

        }
        switch indexPath.row {
        case 4:
            return CGSize(width: 265.0, height: 40.0)
        case 5:
            return CGSize(width: 265.0, height: 40.0)
        default:
            return CGSize(width: (collectionView.bounds.width - 20), height: height / 2.5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch indexPath.row {
        case 4:
            
                self.activity.startAnimating()
                self.pageInt = self.pageInt + 1
                self.ScrapeWebData(self.pageInt, itemPerPage: self.pageNumber, filter: self.videoFilter!)
                self.videoCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                                      at: .top,
                                                      animated: true)
                self.videoCollectionView.dataSource = nil
        case 5:
                self.activity.startAnimating()
                self.pageInt = self.pageInt - 1
                self.ScrapeWebData(self.pageInt, itemPerPage: self.pageNumber, filter: self.videoFilter!)
                self.videoCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                                      at: .top,
                                                      animated: true)
                self.videoCollectionView.dataSource = nil
        default:

            break
        }
    }

    

}
