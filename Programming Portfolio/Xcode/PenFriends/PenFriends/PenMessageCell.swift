//
//  PenMessageCell.swift
//  PenFriends
//
//  Created by Kel Robertson on 5/02/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

class PenMessageCell: UICollectionViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    func configureCell(user:User) {
        usernameLabel.text = user.username
    }
    
}
