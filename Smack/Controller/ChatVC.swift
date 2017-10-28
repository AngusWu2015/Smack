//
//  ViewController.swift
//  Smack
//
//  Created by AndyWu on 2017/10/17.
//  Copyright © 2017年 AndyWu. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#" + channelName
    }
    
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                
            }
        }
    }

}

