//
//  MBProgressHUDView.swift
//  Smack
//
//  Created by AndyWu on 2017/10/25.
//  Copyright © 2017年 AndyWu. All rights reserved.
//

import Foundation
import MBProgressHUD

class MBProgressHUDView {
    static let instance = MBProgressHUDView()
    func ShowHUD(view: UIView,text: String){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = text
    }
    
    func HideHUD(view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
