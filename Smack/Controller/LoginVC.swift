//
//  LoginVC.swift
//  Smack
//
//  Created by AndyWu on 2017/10/17.
//  Copyright © 2017年 AndyWu. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    
    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func createLoginBtnPressed(_ sender: Any) {
        guard let name = usernameTxt.text ,usernameTxt.text != "" else { return }
        guard let pass = passwordTxt.text , passwordTxt.text != "" else { return }
        view.ShowHUD(text: LOADING)
        AuthService.instance.loginUser(email: name, password: pass) { (success) in
            self.view.HideHUD()
            if success {
                print("登入成功")
            }else{
                print("登入失敗")
            }
        }
    }
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATEACCOUNT, sender: nibName)
    }
    
}
