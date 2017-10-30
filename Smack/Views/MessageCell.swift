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
        
        userImg.image = UIImage (named: message.userAvatar)
        userImg.backgroundColor = message.userAvatarColor.returnUIColor()
        
        // 2017-07-13T21:49:25.590Z
        
        guard var isoDate = message.timeStamp else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)//去掉.590Z
        //isoDate = isoDate.substring(to: end)
        isoDate = String(isoDate[..<end])
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStampLbl.text = finalDate
        }
    }

}
