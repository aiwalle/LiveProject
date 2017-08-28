//
//  LJSocketManager.swift
//  LiveProject
//
//  Created by liang on 2017/8/28.
//  Copyright © 2017年 liang. All rights reserved.
//

import Cocoa

class LJSocketManager {
    fileprivate lazy var server : TCPServer = TCPServer(addr: "0.0.0.0", port : 9999)
    
}
