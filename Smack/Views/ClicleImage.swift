//
//  ClicleImage.swift
//  Smack
//
//  Created by AndyWu on 2017/10/25.
//  Copyright © 2017年 AndyWu. All rights reserved.
//

import UIKit

@IBDesignable
class ClicleImage: UIImageView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
