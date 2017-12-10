//
//  UserRankCell.swift
//  PUBGCompanion
//
//  Created by Kel Robertson on 9/09/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SDWebImage

class UserRankCell: UITableViewCell {

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var avatarImg: UIImageView!
    
    func configureCell(data:PlayerRank){
        placeLabel.text = data._place
        playerNameLabel.text = data._playerName
        
        
    }
}
