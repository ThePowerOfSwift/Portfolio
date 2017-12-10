//
//  MomentCell.swift
//  KChat
//
//  Created by Kel Robertson on 9/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation
class RecievedMomentCell: UITableViewCell {
    
    
    @IBOutlet weak var dateCreated: UILabel!
    @IBOutlet weak var momentPreview: UIImageView!
    @IBOutlet weak var momentType: UILabel!
    @IBOutlet weak var momentCaption: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(moment: Moment, image: UIImage? = nil){
        if moment._momentType == "Photo"{
            if image != nil {
                dateCreated.text = moment._dateCreated
                momentPreview.image = image
                momentType.text = moment._momentType
                momentCaption.text = moment._caption
            } else {
                dateCreated.text = moment._dateCreated
                momentPreview.image = RecievedMomentsVC.recievedImageCache.object(forKey: moment._previewImage as NSString)
                momentType.text = moment._momentType
                momentCaption.text = moment._caption
            }
        }
        if moment._momentType == "Video"{
            if image == nil {
                if let imageUrl = NSURL(string:moment._previewImage) {
                    if let img = self.generateThumbnail(url: imageUrl) {
                        RecievedMomentsVC.recievedImageCache.setObject(img, forKey: moment._previewImage as NSString)
                        DispatchQueue.main.async {
                            self.momentPreview.image = RecievedMomentsVC.recievedImageCache.object(forKey: moment._previewImage as NSString)
                            self.dateCreated.text = moment._dateCreated
                            self.momentType.text = moment._momentType
                            self.momentCaption.text = moment._caption
                        }
                    }
                }
                
                
                
            } else {
                
            }
        }
    }
    
    func generateThumbnail(url : NSURL) -> UIImage?{
        let asset: AVAsset = AVAsset(url: url as URL)
        let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        let time        : CMTime = CMTimeMake(1, 30)
        let img         : CGImage
        do {
            try img = assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let frameImg: UIImage = UIImage(cgImage: img)
            return frameImg
        } catch {
            print("KEL: ERROR THUMBNAIL PREVIEW")
        }
        return nil
    }
    
}
