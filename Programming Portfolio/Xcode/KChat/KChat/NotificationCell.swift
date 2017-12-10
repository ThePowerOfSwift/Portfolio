//
//  NotificationCell.swift
//  KChat
//
//  Created by Kel Robertson on 14/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

protocol NotificationCellDelegate {
    func cellAddButtonPressed(cell:NotificationCell, uid: String)
    func cellDenyButtonPressed(cell:NotificationCell, uid: String)

}

class NotificationCell: UITableViewCell {
    
    @IBOutlet weak var ApproveButton: UIButton!
    
    @IBOutlet weak var denyButton: UIButton!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!

    var delegate: NotificationCellDelegate?
    
    var uid: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func notificationCell(notification: Notif, indexPath: NSIndexPath) {
        ApproveButton.isHidden = false
        denyButton.isHidden = false
        usernameLabel.text = notification.username
        messageLabel.text = notification.messgae
        uid = notification.uid
    }
    


    @IBAction func addButtonPressed(sender: AnyObject) {
        delegate?.cellAddButtonPressed(cell: self, uid: uid)
    }
    @IBAction func denyButtonPressed(sender: AnyObject) {
        delegate?.cellDenyButtonPressed(cell: self, uid: uid)
    }

    
    
}
