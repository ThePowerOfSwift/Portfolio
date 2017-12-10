//
//  PUBG_API_SERVICE.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 31/08/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias Completion = (_ suc: Bool?, _ em: String?, _ d: [String:JSON]) -> Void

class BattlegroundsAPI {

    fileprivate static let _instance = BattlegroundsAPI()

    static var instance: BattlegroundsAPI {
        return _instance
    }
    
    
    let headers: HTTPHeaders = [
        "TRN-Api-Key": "5a2cab06-afc8-4d60-afd0-22c85cad214e"
    ]
    
    func GetPUBGStats(_ playerName:String, OnComplete: @escaping Completion){

        let url = "https://pubgtracker.com/api/profile/pc/\(playerName)"

        if let battlegroundApiUrl = URL(string: url) {
            Alamofire.request(battlegroundApiUrl, method: .get , headers: headers).responseJSON { (response) in
                if let result = response.data {
                    UserDefaults.standard.set(result, forKey: "uData")
                    let json = JSON(data: result)
                    if let dict = json.dictionary {
                        if let _ = dict["error"]?.stringValue {
                            OnComplete(false,"No Such User",dict)
                        } else {
                            UserDefaults.standard.set(Date(), forKey: "creationTime")
                            OnComplete(true,"",dict)
                        }

                    } else {
                        OnComplete(false,"No Such User",[:])
                    }
                   
                }
            }
        }
        
    }

    
}
