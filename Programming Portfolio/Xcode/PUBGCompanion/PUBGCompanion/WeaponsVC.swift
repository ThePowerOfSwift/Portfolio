//
//  WeaponsVC.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 9/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import GoogleMobileAds

class WeaponsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var weaponTypes = ["Sniper Rifles","Assault Rifles","SubMachine Guns","Shotguns","Pistols","Miscellaneous","Melee","Throwables"]

    @IBOutlet weak var adBanner: GADBannerView!
    @IBOutlet weak var ViewLabel: UINavigationItem!
    @IBOutlet weak var weaponSelectionCV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewLabel.title = "Weapons"
        adBanner.adUnitID = ADUNITID
        adBanner.rootViewController = self
        let request = GADRequest()
//        request.testDevices = [ kGADSimulatorID,
//                                TESTDEVICE ];
        
        adBanner.load(request)
        weaponSelectionCV.delegate = self
        weaponSelectionCV.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let weapon = weaponTypes[indexPath.row]
        if let cell = weaponSelectionCV.dequeueReusableCell(withReuseIdentifier: "weaponSelectionCell", for: indexPath) as? WeaponSelectionCell {
            cell.configureCell(weaponType: weapon)
            cell.layer.cornerRadius = 5
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.bounds.width - 16), height: 40)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weaponTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "weaponsView", sender:weaponTypes[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weaponsView" {
            if let destination = segue.destination as? WeaponViewVC {
                
                destination.weaponType = sender as! String
            }
        }
    }
}
