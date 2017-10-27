//
//  ChannelVC.swift
//  Smack
//
//  Created by AndyWu on 2017/10/17.
//  Copyright © 2017年 AndyWu. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userImg: ClicleImage!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        userDataDIdChange(Notification(name: NOTIF_USER_DATA_DID_CHANGE))
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDIdChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUserInfo()
        
    }
    func updataChannel() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                self.tableView .reloadData()
            }
        }
    }
    
    func rmAllChannel() {
        MessageService.instance.channels.removeAll()
        self.tableView.reloadData()
    }
    
    @objc func userDataDIdChange(_ notif:Notification) {
        setupUserInfo()
    }
    
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            
            userImg.image = UIImage (named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.avatarColor.returnUIColor()
            updataChannel()
            
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage (named: "menuProfileIcon")
            userImg.backgroundColor = UIColor .clear
            rmAllChannel()
            
        }
    }
    
    @IBAction func addChannelPressed(_ sender: Any) {
        let addChannel = AddChannelVC()
        addChannel.modalTransitionStyle = .crossDissolve
        addChannel.modalPresentationStyle = .custom
        
        present(addChannel, animated: true, completion: nil)
    }
    
    
    @IBAction func LoginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            //Show profile page
             let profil = ProfileVC()
            profil.modalPresentationStyle = .custom
            profil.modalTransitionStyle = .crossDissolve
            
            let ppSegue = ProfilePushSegue (identifier: "ProfileSegue", source: self, destination: profil)
            ppSegue.perform()
            
            //present(profil, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOFIN, sender: nibName)
        }
    }
    
    @IBAction func unwindFromSkillVC(unwindSegue: UIStoryboardSegue) {
        
    }
    
    //MARK:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        } else {
            return ChannelCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
}
