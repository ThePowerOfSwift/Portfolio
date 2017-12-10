//
//  NotificationRequestCell.swift
//  KChat
//
//  Created by Kel Robertson on 25/01/2017.
//  Copyright © 2017 Kel Robertson. All rights reserved.
//

import UIKit

protocol NotificationRequestCellDelegate {
    func cellDenyRequestButtonPressed(cell:NotificationRequestCell, uid: String)
}

class NotificationRequestCell: UITableViewCell {
    @IBOutlet weak var denyRequestButton: UIButton!
    
    @IBOutlet weak var userRequestLabel: UILabel!
    
    @IBOutlet weak var requestMessageLabel: UILabel!
    var delegate: NotificationRequestCellDelegate?
    var uid: String!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func notificationCellRequested(notification: Notif, indexPath: NSIndexPath) {
        uid = notification.uid
        userRequestLabel.text = notification.username
        requestMessageLabel.text = notification.messgae
    }
    @IBAction func denyRequestButtonPressed(sender: AnyObject) {
        delegate?.cellDenyRequestButtonPressed(cell: self, uid: uid)
    }

}
