//
//  VideoResultCell.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 30/08/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftGifOrigin
import NVActivityIndicatorView
import SDWebImage
import SwiftyJSON


class VideoResultCell: UICollectionViewCell {
    
    @IBOutlet weak var videoPreviewImage: UIImageView!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var postedByLabel: UILabel!
    @IBOutlet weak var videoSubLabel: UILabel!
    @IBOutlet weak var videoMainLabel: UILabel!
    @IBOutlet weak var HeartImageView: UIImageView!
    
    func ConfigureCell(_ resultsDict: [Int:SteamVideos], indexP: Int){
        HeartImageView.isHidden = false
        likesCountLabel.text = resultsDict[indexP]?.RatingCount
        videoSubLabel.text = "Battlegrounds Video"
        videoMainLabel.text = resultsDict[indexP]?.Title
        postedByLabel.text = resultsDict[indexP]?.Author
        Alamofire.request(URL(string:(resultsDict[indexP]?.ImgSrc)!)!).responseImage { (response) in
            self.videoPreviewImage.image = response.result.value
        }
    }
    func ConfigureYouTubeCell(_ resultsDict: JSON){
        HeartImageView.isHidden = true
        likesCountLabel.isHidden = true
        videoSubLabel.text = resultsDict["snippet"]["description"].stringValue
        videoMainLabel.text = resultsDict["snippet"]["title"].stringValue
        postedByLabel.text = resultsDict["snippet"]["channelTitle"].stringValue
        videoPreviewImage.sd_setImage(with: URL(string: resultsDict["snippet"]["thumbnails"]["high"]["url"].stringValue)) { (img, err, youTubeCache, u) in
            
        }
        
    }
    func ConfigureCellHiddenHeart(_ resultsDict: [Int:SteamVideos], indexP: Int){
        HeartImageView.isHidden = true
        likesCountLabel.text = resultsDict[indexP]?.RatingCount
        videoSubLabel.text = "Battlegrounds Video"
        videoMainLabel.text = resultsDict[indexP]?.Title
        postedByLabel.text = resultsDict[indexP]?.Author
        Alamofire.request(URL(string:(resultsDict[indexP]?.ImgSrc)!)!).responseImage { (response) in
            self.videoPreviewImage.image = response.result.value
        }
    }


}

class ArtworkResultsCell: UICollectionViewCell {

    var activity: NVActivityIndicatorView!
    
    @IBOutlet weak var gifImageSrc: FLAnimatedImageView!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var postedByLabel: UILabel!

    @IBOutlet weak var videoMainLabel: UILabel!
    @IBOutlet weak var HeartImageView: UIImageView!
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        activity.center = gifImageSrc.center
        self.gifImageSrc.image = nil
        self.activity.stopAnimating()

    }
    override func awakeFromNib() {
        activity = NVActivityIndicatorView(frame: CGRect(x:gifImageSrc.bounds.midX + 25,y:gifImageSrc.bounds.midY, width: 50, height:50) , type: .pacman, color: Y_ORANGE, padding: 10)
        
    }
    func ConfigureCellArt(_ resultsDict: [Int:SteamArtwork], indexP: Int){
        
        activity.layer.cornerRadius = 50
        activity.backgroundColor = DARK_GREY
        activity.center = gifImageSrc.center
        self.addSubview(activity)
        HeartImageView.isHidden = false
        likesCountLabel.text = resultsDict[indexP]?.RatingCount
        videoMainLabel.text = resultsDict[indexP]?.Title
        postedByLabel.text = resultsDict[indexP]?.Author!
        self.activity.startAnimating()
        DispatchQueue.global(qos: .background).async{
            
            self.gifImageSrc.sd_setImage(with: URL(string:(resultsDict[indexP]?.ImgSrc!)!), completed: { (Image, Error, imageCache, u) in
                DispatchQueue.main.async {
                    self.layer.cornerRadius = 5
                    self.activity.stopAnimating()
                }
                
            })
            
        }

    }
    func ConfigureCellHiddenHeartArt(_ resultsDict: [Int:SteamArtwork], indexP: Int){
        activity = NVActivityIndicatorView(frame: CGRect(x:gifImageSrc.bounds.midX + 25 ,y:gifImageSrc.bounds.midY, width: 50, height:50) , type: .pacman, color: Y_ORANGE, padding: 10)

        activity.startAnimating()
        activity.layer.cornerRadius = 50
        activity.backgroundColor = DARK_GREY
        self.addSubview(activity)
        HeartImageView.isHidden = true
        likesCountLabel.text = resultsDict[indexP]?.RatingCount
        videoMainLabel.text = resultsDict[indexP]?.Title
        postedByLabel.text = resultsDict[indexP]?.Author
       self.activity.startAnimating()
        DispatchQueue.global(qos: .background).async{

            self.gifImageSrc.sd_setImage(with: URL(string:(resultsDict[indexP]?.ImgSrc!)!), completed: { (Image, Error, imageCache, u) in
                DispatchQueue.main.async {
                    self.layer.cornerRadius = 5
                    self.activity.stopAnimating()
                }
                
            })
            
        }
    }

}


class GifyCell: UICollectionViewCell {

    @IBOutlet weak var gifyImage: FLAnimatedImageView!
    @IBOutlet weak var caption: UILabel!
    var activity: NVActivityIndicatorView!
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        activity.center = gifyImage.center
        self.gifyImage.image = nil
        self.activity.stopAnimating()
    }
    override func awakeFromNib() {
        activity = NVActivityIndicatorView(frame: CGRect(x:gifyImage.bounds.midX + 25,y:gifyImage.bounds.midY, width: 50, height:50) , type: .pacman, color: Y_ORANGE, padding: 10)
        
    }
    func ConfigureCell(data: JSON){
        activity.layer.cornerRadius = 50
        activity.backgroundColor = DARK_GREY
        
        self.addSubview(activity)
        self.activity.startAnimating()
        DispatchQueue.global(qos: .background).async{
           
            let str = data["images"]["fixed_height"]["url"].stringValue.replacingOccurrences(of: "media1", with: "i")
            self.gifyImage.sd_setImage(with: URL(string:str), completed: { (Image, Error, imageCache, u) in
                
                DispatchQueue.main.async {
                    self.activity.stopAnimating()
                    self.layer.cornerRadius = 5
                    self.caption.text = data["source_tld"].stringValue
                    
                }
            })
            
        }
    }
}
