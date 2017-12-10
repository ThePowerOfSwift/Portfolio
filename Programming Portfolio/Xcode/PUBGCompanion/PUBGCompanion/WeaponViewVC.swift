//
//  WeaponViewVC.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 9/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kanna
import NVActivityIndicatorView

class WeaponViewVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var weaponCollectionView: UICollectionView!
    
    @IBOutlet weak var ViewTitle: UINavigationItem!
    var activity: NVActivityIndicatorView!
    
    var weaponType: String!
    
    var weaponsData = [Int:Weapons]()
    var throwableData = [Int:Throwable]()
    var meleeData = [Int:Melee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewTitle.title = weaponType
        LoadActivity()
        weaponCollectionView.delegate = self

        ParseData(wType: weaponType)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width - 16)
        let height = (collectionView.bounds.height - 10)
        
        return CGSize(width: width, height: height)
    }

    func ParseData(wType:String!){
            let json = PUBGMEItems.instance._itemsData
            switch self.weaponType {
            case "Throwables":
                var x = 0
                for obj in json["Weapons"]["\(wType.replacingOccurrences(of: " ", with: ""))"].arrayValue {
                    throwableData[x] = Throwable(weaponTitle: obj["title"].stringValue, weaponDesc: obj["desc"].stringValue, weaponImgSrc: obj["imgSrc"].stringValue, pickupDelay: obj["pickupDelay"].stringValue, readyDelay: obj["readyDelay"].stringValue)
                    x += 1
                }
                break
            case "Melee":
                var x = 0
                for obj in json["Weapons"]["\(wType.replacingOccurrences(of: " ", with: ""))"].arrayValue {
                    meleeData[x] = Melee(weaponTitle: obj["title"].stringValue, weaponDesc: obj["desc"].stringValue, weaponImgSrc: obj["imgSrc"].stringValue, damage: obj["dmg"].stringValue, impact: obj["impact"].stringValue, hitRangeLeeway: obj["hitRangeLeeway"].stringValue)
                    x += 1
                }
                break
            default:
                var x = 0
                for obj in json["Weapons"]["\(wType.replacingOccurrences(of: " ", with: ""))"].arrayValue {
                    weaponsData[x] = Weapons(weaponTitle: obj["title"].stringValue, weaponDesc: obj["desc"].stringValue, weaponImgSrc: obj["imgSrc"].stringValue, hitDamage: obj["hitDmg"].stringValue, bulletSpeed: obj["IBS"].stringValue, bodyHitImpactPower: obj["BHIP"].stringValue, zeroingRange: obj["zeroRange"].stringValue, ammoPerMag: obj["ammoPerMag"].stringValue, timeBetweenShots: obj["TBS"].stringValue, reloadTime: obj["reloadTime"].stringValue, firingModes: obj["firingModes"].stringValue, ammo: obj["ammo"][0]["aTitle"].stringValue, ammoImg: obj["ammo"][0]["aSrc"].stringValue)
                    x += 1
                }
                break
            }
        
        
        DispatchQueue.main.async {
            self.activity.stopAnimating()
            self.weaponCollectionView.dataSource = self
            self.weaponCollectionView.reloadData()
        }

        
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        switch self.weaponType {
        case "Throwables":
            let weapon = throwableData[indexPath.row]
            if let throwCell = weaponCollectionView.dequeueReusableCell(withReuseIdentifier: "throwableCell", for: indexPath) as? ThrowableCell {
                throwCell.ConfigureCell(w: weapon!)
                throwCell.layer.masksToBounds = true
                throwCell.layer.cornerRadius = 5
                return throwCell
            }
        case "Melee":
            let weapon = meleeData[indexPath.row]
            if let meleeCell = weaponCollectionView.dequeueReusableCell(withReuseIdentifier: "meleeCell", for: indexPath) as? MeleeCell {
                meleeCell.ConfigureCell(w: weapon!)
                meleeCell.layer.masksToBounds = true
                meleeCell.layer.cornerRadius = 5
                return meleeCell
            }
        default:
            let weapon = weaponsData[indexPath.row]
            if let weaponCell = weaponCollectionView.dequeueReusableCell(withReuseIdentifier: "weaponCell", for: indexPath) as? WeaponCell {
                weaponCell.ConfigureCell(w: weapon!)
                weaponCell.layer.masksToBounds = true
                weaponCell.layer.cornerRadius = 5
                return weaponCell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.weaponType {
        case "Throwables":
            return throwableData.count
        case "Melee":
            return meleeData.count
        default:
            return weaponsData.count
        }
    }
    
}
