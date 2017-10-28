//
//  AddChannelVC.swift
//  Smack
//
//  Created by AndyWu on 2017/10/27.
//  Copyright © 2017年 AndyWu. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var showView: UIView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var chanDesc: UITextField!
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
  
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let channelName = nameTxt.text , nameTxt.text != "" else { return }
        guard let channelDesc = chanDesc.text , chanDesc.text != "" else { return }
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDesc) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        let closeTouch = UITapGestureRecognizer (target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        nameTxt.attributedPlaceholder = NSAttributedString (string: "name", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceholder])
        chanDesc.attributedPlaceholder = NSAttributedString (string: "description", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceholder])
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

}
