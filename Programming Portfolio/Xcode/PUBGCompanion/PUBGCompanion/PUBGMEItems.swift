//
//  PUBGMEItems.swift
//  PUBG Hub
//
//  Created by Kel Robertson on 5/10/17.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation
import SwiftyJSON

class PUBGMEItems {
    
    fileprivate static let _instance = PUBGMEItems()
    
    static var instance: PUBGMEItems {
        return _instance
    }
    
    private var itemsData: JSON!
    
    var _itemsData: JSON {
        return itemsData
    }
    
    func PubgItems(){
        if let aData = NSData(contentsOf:ALLDATA!) {
            self.itemsData = JSON(data: aData as Data)
        }
        
    }
}
