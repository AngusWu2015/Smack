//
//  ViewController.swift
//  Smack
//
//  Created by AndyWu on 2017/10/17.
//  Copyright © 2017年 AndyWu. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var messageTxtBox: UITextField!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var typingUsersLbl: UILabel!
    
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bindToKeyboard()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80.0
        sendBtn.isEnabled = false
        
        let tap = UITapGestureRecognizer (target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        //登入&登出處理
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDIdChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        //選擇渠道處理
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        // 監聽訊息
        SocketService.instance.getMessage { (newMessage) in
            if newMessage.channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.messages.append(newMessage)
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0  && self.tableView.contentOffset.y < (self.tableView.contentSize.height - self.tableView.frame.size.height){
                    let indIndex = IndexPath (row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: indIndex, at: .bottom, animated: false)
                }

//                if MessageService.instance.messages.count > 0 {
//                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
//                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
//                }
            }
        }
//        SocketService.instance.getMessage { (success) in
//            if success {
//                self.tableView.reloadData()
//                if MessageService.instance.messages.count > 0  && self.tableView.contentOffset.y < (self.tableView.contentSize.height - self.tableView.frame.size.height){
//                    let indIndex = IndexPath (row: MessageService.instance.messages.count - 1, section: 0)
//                    self.tableView.scrollToRow(at: indIndex, at: .bottom, animated: false)
//                }
//            }
//        }
        // 監聽輸入？XDD
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser, channel) in typingUsers {
                if typingUser != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.typingUsersLbl.text = "\(names) \(verb) typing a message"
            } else {
                self.typingUsersLbl.text = ""
            }
            
        }
        
        //判斷是否有登入
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
            tableView.reloadData()
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
                    if  self.tableView.contentOffset.y == (self.tableView.contentSize.height - self.tableView.frame.size.height){
                        let indIndex = IndexPath (row: MessageService.instance.messages.count - 1, section: 0)
                        self.tableView.scrollToRow(at: indIndex, at: .bottom, animated: false)
                    }
                    self.isTyping = false
                    self.sendBtn.isEnabled = false
                    SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
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
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
    //判斷send 是否出現 ＆ 發送、結束 正在打字....
    @IBAction func messageBoxEditing(_ sender: Any) {
        guard let channelId = MessageService.instance.selectedChannel?.id else {
            return
        }
        if messageTxtBox.text == "" {
            isTyping = false
            sendBtn.isEnabled = false
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
        } else {
            if isTyping == false {
                sendBtn.isEnabled = true
                SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId)
            }
            isTyping = true
        }
    }
    
    //MARK: TableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        }
        return UITableViewCell()
    }

}

