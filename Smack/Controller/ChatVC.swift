//
//  ViewController.swift
//  Smack
//
//  Created by AndyWu on 2017/10/17.
//  Copyright © 2017年 AndyWu. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    @IBOutlet weak var messageTxtBox: UITextField!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bindToKeyboard()
        
        let tap = UITapGestureRecognizer (target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDIdChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            view.ShowHUD(text: "")
            AuthService.instance.findUserByEmail(completion: { (success) in
                self.view.HideHUD()
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }

    }

    @objc func userDataDIdChange(_ notif:Notification) {
        if AuthService.instance.isLoggedIn {
            //get channels
            onLoginGetMessages()
        } else {
            channelNameLbl.text = "請登入"
        }
    }
    
    @objc func channelSelected(_ notif:Notification) {
        updateWithChannel()
    }
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#" + channelName
        getMessages()
    }
    
    
    @IBAction func sendMsgPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let message = messageTxtBox.text, messageTxtBox.text != "" else { return }
            
            let User = UserDataService.instance
            SocketService.instance.addMessage(messageBody: message, userId: User.id, channelId: channelId, completion: { (success) in
                if success {
                    self.messageTxtBox.text = ""
                    self.messageTxtBox.resignFirstResponder()
                }
            })
        }
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLbl.text = "NO Channels!"
                }
            }
        }
    }
    
    func getMessages() {
        guard let channlId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessageForChann(channelId: channlId) { (success) in
            
        }
    }

}

