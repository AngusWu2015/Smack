//
//  MessageCell.swift
//  Smack
//
//  Created by AndyWu on 2017/10/29.
//  Copyright © 2017年 AndyWu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBodyLbl: UILabel!
    @IBOutlet weak var userImg: ClicleImage!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message: Message) {
        messageBodyLbl.text = message.message
        userNameLbl.text = message.userName
        timeStampLbl.text = message.timeStamp
        userImg.image = UIImage (named: message.userAvatar)
        userImg.backgroundColor = message.userAvatarColor.returnUIColor()
    }

}
