//
//  ShareVC.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 10/11/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKShareKit

class ShareVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var stat: Stats!
    var pImage: UIImage? = nil
    var pName: String!
    var lastUpdated: String!
    
    @IBOutlet weak var extStatCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if stat != nil {
            extStatCV.dataSource = self
            extStatCV.delegate = self
            DispatchQueue.main.async {
                if let _ = self.extStatCV.cellForItem(at: IndexPath(row:0, section:0)) as? ExtendedStatsCell {
                    let image = UIImage.init(view: self.extStatCV.visibleCells[0].contentView)
                    let photo:FBSDKSharePhoto = FBSDKSharePhoto()
                    photo.image = image
                    photo.isUserGenerated = true
                    let content:FBSDKSharePhotoContent = FBSDKSharePhotoContent()
                    content.photos = [photo]
                    let shareButton = FBSDKShareButton()
                    shareButton.shareContent = content
                    self.navigationController?.navigationBar.topItem?.titleView = shareButton
                    shareButton.center = (self.navigationController?.navigationBar.center)!
                    if shareButton.isEnabled == false {
                        let alert = UIAlertController(title: "Facebook Error", message: "Facebook must be installed for sharing to work.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.destructive, handler: { action in
                            self.dismiss(animated: false, completion: nil)
                        }))
                        self.present(alert, animated: true, completion:nil)
                    }
                }
            }
            

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = extStatCV.dequeueReusableCell(withReuseIdentifier: "extendedStatsCell", for: indexPath) as? ExtendedStatsCell {
            cell.ConfigureCell(data: stat, pImage: pImage!, pName: pName, lUpdated: lastUpdated)
            cell.layer.cornerRadius = 5
            return cell
        }
        return UICollectionViewCell()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.bounds.width - 20), height: 550)
    }
}
