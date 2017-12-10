//
//  SteamService.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 6/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
typealias Completion = (_ suc: Bool?, _ em: String?, _ d: [String:JSON]) -> Void

class SteamService {
    fileprivate static let _instance = SteamService()
    
    static var instance: SteamService {
        return _instance
    }
    
    let headers: HTTPHeaders = [
        "Key": "ED278421E50621E420C39220D71E2798"
    ]
    
    func GetSteamNews(_ OnComplete: @escaping Completion){
        let url = "https://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=578080&format=json"
        if let steamNewsApiURL = URL(string: url) {
            Alamofire.request(steamNewsApiURL, method: .get , headers: headers).responseJSON { (response) in
                if let result = response.data {
                    
                    let json = JSON(data: result)
                    if let dict = json.dictionary {
                        
                        OnComplete(true,"",dict)
                    }
                    
                }
            }
        }
        
    }
    
}
