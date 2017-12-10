//
//  ItemViewVC.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 10/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
import SwiftyJSON

class ItemViewVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var itemTableView: UITableView!
    var itemType: String!
    
    @IBOutlet weak var ViewTitle: UINavigationItem!
    var attachementData = [Int:Attachments]()
    var consumablesData = [Int:Consumables]()
    var cosmeticsData = [Int:Cosmetics]()
    var ammunitionData = [Int:Ammunition]()
    var equipmentData = [Int:Equipment]()

    var activity: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ViewTitle.title = itemType
        itemTableView.delegate = self
        LoadActivity()
        if let i = itemType {
            ParseData(item: i)
        }
    }
    
    func ParseData(item:String!){
        let json = PUBGMEItems.instance._itemsData
        switch itemType {
        case "Equipment":
                var x = 0
                for obj in json["Equipment"].arrayValue {
                    equipmentData[x] = Equipment(title: obj["title"].stringValue, capacityExt: obj["capacityExt"].stringValue, dmgReduction: obj["dmgReduction"].stringValue, durability: obj["durability"].stringValue, weight: obj["weight"].stringValue, itemImage: obj["imgSrc"].stringValue)
                    x += 1
                }
                itemTableView.dataSource = self
                itemTableView.reloadData()
                activity.stopAnimating()
            break
        case "Ammunition":
                var x = 0
                for obj in json["Ammo"].arrayValue {
                    ammunitionData[x] = Ammunition(title: obj["aTitle"].stringValue, itemImage: obj["aSrc"].stringValue, desc: obj["desc"].stringValue)
                    x += 1
                }
                itemTableView.dataSource = self
                itemTableView.reloadData()
                activity.stopAnimating()
            break
        case "Consumables":
                var x = 0
                for obj in json["Consumables"].arrayValue {
                    consumablesData[x] = Consumables(title: obj["title"].stringValue, itemImage: obj["imgSrc"].stringValue, desc: obj["desc"].stringValue, castTime: obj["castTime"].stringValue)
                    x += 1
                }
                itemTableView.dataSource = self
                itemTableView.reloadData()
                activity.stopAnimating()
            break
        case "Cosmetics":
                var x = 0
                for obj in json["Cosmetics"].arrayValue {
                    cosmeticsData[x] = Cosmetics(title: obj["title"].stringValue, itemImage: obj["imgSrc"].stringValue)
                    x += 1
                }
                itemTableView.dataSource = self
                itemTableView.reloadData()
                activity.stopAnimating()
            break
        case "Attachments":
                var x = 0
                for obj in json["Attachments"].arrayValue {
                    attachementData[x] = Attachments(title: obj["title"].stringValue, itemImage: obj["imgSrc"].stringValue, desc: obj["desc"].stringValue, value1: obj["val1"].stringValue, value2: obj["val2"].stringValue, value3: obj["val3"].stringValue, value4: obj["val4"].stringValue, value5: obj["val5"].stringValue, value6: obj["val6"].stringValue)
                    x += 1
                }
            break
        default:
            break
        }
        DispatchQueue.main.async {
            self.itemTableView.dataSource = self
            self.itemTableView.reloadData()
            self.activity.stopAnimating()
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch itemType {
        case "Equipment":
            let item = equipmentData[indexPath.row]
            if let equipCell = itemTableView.dequeueReusableCell(withIdentifier: "equipmentCell", for: indexPath) as? EquipmentCell {
                equipCell.ConfigureCell(d: item!)
                return equipCell
            }
            break
        case "Ammunition":
            let item = ammunitionData[indexPath.row]
            if let ammoCell = itemTableView.dequeueReusableCell(withIdentifier: "ammunitionCell", for: indexPath) as? AmmunitionCell {
                ammoCell.ConfigureCell(d: item!)
                return ammoCell
            }
        case "Consumables":
            let item = consumablesData[indexPath.row]
            if let consCell = itemTableView.dequeueReusableCell(withIdentifier: "consumablesCell", for: indexPath) as? ConsumablesCell {
                consCell.ConfigureCell(d: item!)
                return consCell
            }
            break
        case "Cosmetics":
            let item = cosmeticsData[indexPath.row]
            if let cosCell = itemTableView.dequeueReusableCell(withIdentifier: "cosmeticsCell", for: indexPath) as? CosmeticsCell {
                cosCell.ConfigureCell(d: item!)
                return cosCell
            }
            break
        case "Attachments":
            let item = attachementData[indexPath.row]
            if let attCell = itemTableView.dequeueReusableCell(withIdentifier: "attachementCell", for: indexPath) as? AttachementCell {
                attCell.ConfigureCell(d: item!)
                return attCell
            }
            break
        default:
            break
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch itemType {
        case "Equipment":
            return equipmentData.count
        case "Ammunition":
            return ammunitionData.count
        case "Consumables":
            return consumablesData.count
        case "Cosmetics":
            return cosmeticsData.count
        case "Attachments":
            return attachementData.count
        default:
            break
        }
        return 0
    }

}
