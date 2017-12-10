//
//  FriendCell.swift
//  KChat
//
//  Created by Kel Robertson on 8/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCheckmark(selected: false)
    }
    
    func updateUI(user: User) {
        userName.text = user.username
    }
    
    func setCheckmark(selected: Bool) {
        let imgStr = selected ? "messageindicatorchecked1" : "messageindicator1"
        self.accessoryView = UIImageView(image: UIImage(named: imgStr))
    }

}
