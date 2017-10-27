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
    @IBOutlet weak var showView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        userImg.image = UIImage (named: UserDataService.instance.avatarName)
        userImg.backgroundColor = UserDataService.instance.avatarColor.returnUIColor()
        userName.text = UserDataService.instance.name
        email.text = UserDataService.instance.email
        bgview.backgroundColor = UIColor.clear
        //print(UserDataService.instance.name)
        let closeTouch = UITapGestureRecognizer (target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgview.addGestureRecognizer(closeTouch)
        // Do any additional setup after loading the view.
        
        self.bgview.backgroundColor = UIColor.black
        self.bgview.alpha = 0.3
    }

    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) {
            
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
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

class ProfilePushSegue: UIStoryboardSegue {
    override func perform() {
        let VCBVC: ProfileVC = self.destination as! ProfileVC  // 來源端(ViewController B)
        let VCAVC = self.source as UIViewController!  // 目的端(ViewController A)
        
        // 取得畫面的寬度與高度
        
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(VCBVC.view!, aboveSubview: (VCAVC?.view!)!)
        
        
        let screenHeight = UIScreen.main.bounds.size.height
        let screenWidth = UIScreen.main.bounds.size.width
        
        VCBVC.showView.frame = CGRect(x: VCBVC.showView.frame.origin.x, y: screenHeight, width: screenWidth-40, height: screenWidth-40)
        VCBVC.bgview.alpha = 0.0
        VCBVC.bgview.frame = CGRect (x: 0, y: 0, width: screenWidth, height: screenHeight)
        VCBVC.view.frame = CGRect (x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        
        
        //開始轉場
        UIView.animate(withDuration: 0.3, animations: {
            VCBVC.bgview.alpha = 0.3
            VCBVC.showView.center = VCBVC.bgview.center
        }) { (finsish) in
            self.source.present(self.destination as UIViewController, animated: false, completion: nil)
        }
        
    }
}
