//
//  ChannelVC.swift
//  Smack
//
//  Created by AndyWu on 2017/10/17.
//  Copyright © 2017年 AndyWu. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }

    @IBAction func LoginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOFIN, sender: nibName)
    }
    
    @IBAction func unwindFromSkillVC(unwindSegue: UIStoryboardSegue) {
        
    }
}
