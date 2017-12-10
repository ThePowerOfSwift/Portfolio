//
//  ItemsVC.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 10/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ItemsVC: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var itemTypes = ["Equipment", "Cosmetics", "Attachments", "Consumables", "Ammunition"]

    @IBOutlet weak var adBanner: GADBannerView!
    @IBOutlet weak var ViewLabel: UINavigationItem!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewLabel.title = "Items"
        adBanner.adUnitID = ADUNITID
        adBanner.rootViewController = self
        let request = GADRequest()
//        request.testDevices = [ kGADSimulatorID,
//                                TESTDEVICE ];
        
        adBanner.load(request)
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.bounds.width - 16), height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = itemTypes[indexPath.row]
        if let itemCell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: "itemSelectionCell", for: indexPath) as? ItemSelectionCell {
            itemCell.configureCell(itemType: item)
            itemCell.layer.cornerRadius = 5
            return itemCell
        }
        return UICollectionViewCell()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemTypes.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = itemTypes[indexPath.row]
        performSegue(withIdentifier: "itemView", sender: item)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemView" {
            if let destination = segue.destination as? ItemViewVC {
                destination.itemType = sender as! String
            }
        }
    }
}
