//
//  ViewController.swift
//  clientSocket
//
//  Created by liang on 2017/8/28.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    
    fileprivate lazy var socket = LJSocket(addr: "172.16.25.101", port: 9999)
    
    fileprivate var timer : Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if socket.connectServe(timeout: 10) {
            print("连接成功")
            socket.readMessage()
            timer = Timer(fireAt: Date(), interval: 9, target: self, selector: #selector(sendHeartBeat), userInfo: nil, repeats: true)
            RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        }
    }


    deinit {
        timer.invalidate()
        timer = nil
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            socket.sendEnterRoom()
        case 1:
            socket.sendLeaveRoom()
        case 2:
            socket.sendTextMsg("hello world")
        case 3:
            socket.sendGiftMsg("我是一个小礼物", giftUrlStr: "http://www.hello.com", giftCount: 20)
        default:
            print("未识别消息")
        }
    }
    
    
    
    
    @objc func sendHeartBeat() {
        socket.sendHeartBeat()
    }
}

