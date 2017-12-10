//
//  ItemCells.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 10/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class EquipmentCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var capacityExt: UILabel!
    @IBOutlet weak var dmgReduciton: UILabel!
    @IBOutlet weak var durability: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    func ConfigureCell(d:Equipment){
        dmgReduciton.text = d.dmgReduction
        title.text = d.title!
        capacityExt.text = d.capacityExt
        durability.text = d.durability
        weight.text = d.weight
        Alamofire.request(d.itemImage).responseImage { (Img) in
            self.itemImage.image = Img.result.value
        }
    }

}
class CosmeticsCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    func ConfigureCell(d:Cosmetics){

        title.text = d.title
        Alamofire.request(d.itemImage).responseImage { (Img) in
            self.itemImage.image = Img.result.value
        }
    }
}
class AttachementCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var value1: UILabel!
    @IBOutlet weak var value2: UILabel!
    @IBOutlet weak var value3: UILabel!
    @IBOutlet weak var value4: UILabel!
    @IBOutlet weak var value5: UILabel!
    @IBOutlet weak var value6: UILabel!
    func ConfigureCell(d:Attachments){
        title.text = d.title
        desc.text = d.desc
        value1.text = d.value1
        value2.text = d.value2
        value3.text = d.value3
        value4.text = d.value4
        value5.text = d.value5
        value6.text = d.value6
        Alamofire.request(d.itemImage).responseImage { (Img) in
            self.itemImage.image = Img.result.value
        }
    }
    
}
class ConsumablesCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var casttime: UILabel!
    func ConfigureCell(d:Consumables){
        title.text = d.title
        desc.text = d.desc
        casttime.text = d.castTime
        Alamofire.request(d.itemImage).responseImage { (Img) in
            self.itemImage.image = Img.result.value
        }
    }
}
class AmmunitionCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var desc: UILabel!
    func ConfigureCell(d:Ammunition){
        title.text = d.title
        desc.text = d.desc
        Alamofire.request(d.itemImage).responseImage { (Img) in
            self.itemImage.image = Img.result.value
        }
    }
}
