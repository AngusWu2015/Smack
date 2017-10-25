//
//  ProfileVC.swift
//  Smack
//
//  Created by AndyWu on 2017/10/26.
//  Copyright © 2017年 AndyWu. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var bgview: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        userImg.image = UIImage (named: UserDataService.instance.avatarName)
        userImg.backgroundColor = UserDataService.instance.avatarColor.returnUIColor()
        userName.text = UserDataService.instance.name
        email.text = UserDataService.instance.email
        bgview.backgroundColor = UIColor.clear
        
        let closeTouch = UITapGestureRecognizer (target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgview.addGestureRecognizer(closeTouch)
        // Do any additional setup after loading the view.
    }

    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) {
            self.bgview.backgroundColor = UIColor.black
            self.bgview.alpha = 0.3
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        bgview.isHidden = true
    }

    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
    }
    
}
