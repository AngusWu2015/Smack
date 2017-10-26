//
//  Channel.swift
//  Smack
//
//  Created by AndyWu on 2017/10/26.
//  Copyright © 2017年 AndyWu. All rights reserved.
//

import Foundation

struct Channel : Decodable {
    public private(set) var name: String!
    public private(set) var description: String!
    public private(set) var _id: String!
    public private(set) var __v: Int!
}
