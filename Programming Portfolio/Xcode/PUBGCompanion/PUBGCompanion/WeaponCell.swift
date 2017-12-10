//
//  WeaponCell.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 9/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class WeaponCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var weaponImage: UIImageView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var hitDmg: UILabel!
    @IBOutlet weak var bulletSpeed: UILabel!
    @IBOutlet weak var BHIP: UILabel!
    @IBOutlet weak var zeroingRange: UILabel!
    @IBOutlet weak var ammorPerMag: UILabel!
    @IBOutlet weak var timeBetweenShots: UILabel!
    @IBOutlet weak var reloadTime: UILabel!
    @IBOutlet weak var firingModes: UILabel!
    @IBOutlet weak var ammoImg: UIImageView!
    @IBOutlet weak var ammoLabel: UILabel!
    
    func ConfigureCell(w:Weapons) {
        title.text = w.weaponTitle
        Alamofire.request(w.weaponImgSrc).responseImage { (Img) in
            self.weaponImage.image = Img.result.value
        }
        Alamofire.request(w.ammoImg).responseImage { (Img) in
            self.ammoImg.image = Img.result.value
        }

        ammoLabel.text = w.ammo
        desc.text = w.weaponDesc
        hitDmg.text = w.hitDamage
        bulletSpeed.text = w.bulletSpeed
        BHIP.text = w.bodyHitImpactPower
        zeroingRange.text = w.zeroingRange
        ammorPerMag.text = w.ammoPerMag
        timeBetweenShots.text = w.timeBetweenShots
        reloadTime.text = w.reloadTime.replacingOccurrences(of: "00", with: "")
        firingModes.text = w.firingModes
    }
    
}

class ThrowableCell:UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var weaponImage: UIImageView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var pickupDelay: UILabel!
    @IBOutlet weak var readyDelay: UILabel!
    func ConfigureCell(w:Throwable) {
        title.text = w.weaponTitle
        Alamofire.request(w.weaponImgSrc).responseImage { (Img) in
            self.weaponImage.image = Img.result.value
        }
        desc.text = w.weaponDesc
        pickupDelay.text = w.pickupDelay
        readyDelay.text = w.readyDelay
    }
}
class MeleeCell:UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var weaponImage: UIImageView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var damage: UILabel!
    @IBOutlet weak var impact: UILabel!
    @IBOutlet weak var hitRangeLeeway: UILabel!
    func ConfigureCell(w:Melee) {
        title.text = w.weaponTitle
        Alamofire.request(w.weaponImgSrc).responseImage { (Img) in
            self.weaponImage.image = Img.result.value
        }
        desc.text = w.weaponDesc
        damage.text = w.damage
        impact.text = w.impact
        hitRangeLeeway.text = w.hitRangeLeeway
        
    }
}
