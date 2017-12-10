//
//  MyFriendsCell.swift
//  KChat
//
//  Created by Kel Robertson on 14/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

class MyFriendsCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUI (user: User) {
        usernameLabel.text = user.username
    }
    
}
