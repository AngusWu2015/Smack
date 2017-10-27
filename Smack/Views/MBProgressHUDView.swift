//
//  MBProgressHUDView.swift
//  Smack
//
//  Created by AndyWu on 2017/10/25.
//  Copyright © 2017年 AndyWu. All rights reserved.
//

import Foundation
import MBProgressHUD

extension UIView {
    
    func ShowHUD(text: String){
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
         hud.label.text = text
    }
    
    func HideHUD() {
        MBProgressHUD.hide(for: self, animated: true)
    }
}
