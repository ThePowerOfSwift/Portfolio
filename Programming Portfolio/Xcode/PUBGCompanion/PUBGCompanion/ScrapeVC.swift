//
//  ScrapeVC.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 2/11/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Alamofire
import Kanna
import SwiftyJSON

class ScrapeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PUBGTRACKER.instance.PlayerData(name: "kellogs") { (suc, msg) in
            if(suc)!{
                
                for stats in PUBGTRACKER.instance.stats {
                    if stats.Region != "agg"{
                        stats.listPropertiesWithValues()
                    }
                    
                }
                
                
            }
        }
        // Do any additional setup after loading the view.
    }

}
