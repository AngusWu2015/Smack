//
//  ViewController.swift
//  Smack
//
//  Created by AndyWu on 2017/10/17.
//  Copyright © 2017年 AndyWu. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
//        let av = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height / 4))
//        av.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
//        av.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(av)
//        av.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        av.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        av.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        av.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
//        
        
        
    }

   

}

