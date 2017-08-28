//
//  LJClientManager.swift
//  LiveProject
//
//  Created by liang on 2017/8/28.
//  Copyright © 2017年 liang. All rights reserved.
//

import Cocoa

protocol LJClientManagerDelegate : class {
    func sendMsgToClient(_ data : Data)
    func removeClient(client : LJClientManager)
}


class LJClientManager : NSObject {
    
    weak var delegate : LJClientManagerDelegate?
    
    var client : TCPClient
    fileprivate var isClientConnecting : Bool = false
    
    fileprivate var heartTimeCount : Int = 0
    
    init(client : TCPClient) {
        self.client = client
    }
}

extension LJClientManager {
    func readMessage() {
        isClientConnecting = true
        while isClientConnecting {
            if let headMsg = client.read(4) {
                let timer = Timer(fireAt: Date(), interval: 1, target: self, selector: #selector(checkHeartBeat), userInfo: nil, repeats: true)
                RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
                timer.fire()
                
                let headData = Data(bytes: headMsg, count: 4)
                var actualLength = 0
                // 给actualLength赋值，获取消息内容长度
                (headData as NSData).getBytes(&actualLength, length: 4)
                
                guard let typeMsg = client.read(2) else {
                    return
                }
                
                let typeData = Data(bytes: typeMsg, count: 2)
                var type = 0
                (typeData as NSData).getBytes(&type, length: 2)
                
                
                guard let actualMsg = client.read(actualLength) else {
                    return
                }
                
                let actualData = Data(bytes: actualMsg, count: actualLength)
                let actualMsgStr = String(data: actualData, encoding: .utf8)
                if type == 1 {
                    removeClient()
                } else if type == 100 {
                    heartTimeCount += 1
                    continue
                }
                print(actualMsgStr ?? "解析消息出错")
                let totalData = headData + typeData + actualData
                delegate?.sendMsgToClient(totalData)
            } else {
                removeClient()
            }
        }
    }
    
    @objc fileprivate func checkHeartBeat() {
        heartTimeCount += 1
        if heartTimeCount >= 10 {
            removeClient()
        }
        print("收到了心跳包")
    }
    
    private func removeClient() {
        delegate?.removeClient(client: self)
        isClientConnecting = false
        print("客户端断开了连接")
        _ = client.close()
    }
}
