//
//  CreateAccountVC.swift
//  Smack
//
//  Created by AndyWu on 2017/10/17.
//  Copyright © 2017年 AndyWu. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closeBtnPressed (_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountBtnPressed(_ sender: Any?) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }

}
