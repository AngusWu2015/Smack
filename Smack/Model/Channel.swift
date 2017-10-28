//
//  Channel.swift
//  Smack
//
//  Created by AndyWu on 2017/10/26.
//  Copyright © 2017年 AndyWu. All rights reserved.
//

import Foundation

struct Channel : Decodable {
    public private(set) var channelTitle: String!
    public private(set) var channelDescription: String!
    public private(set) var id: String!
}
