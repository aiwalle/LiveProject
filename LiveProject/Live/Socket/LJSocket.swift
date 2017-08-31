//
//  LJSocket.swift
//  LiveProject
//
//  Created by liang on 2017/8/28.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit
import ProtocolBuffers


enum MessageType : Int {
    case enterRoomMessage = 0
    case leaveRoomMessage = 1
    case textMessage = 2
    case giftMessage = 3
    case heartBeatSignal = 100
}

protocol LJSocketDelegate : class {
    func socket(_ socket: LJSocket, enterRoom user: UserInfo)
    func socket(_ socket: LJSocket, leaveRoom user: UserInfo)
    func socket(_ socket: LJSocket, textMsg: ChatMessage)
    func socket(_ socket: LJSocket, giftMsg: GiftMessage)
}

class LJSocket {
    weak var delegate : LJSocketDelegate?
    
    fileprivate var client : TCPClient
    fileprivate var isConnected : Bool = false
    fileprivate lazy var user : UserInfo.Builder = {
        let user = UserInfo.Builder()
        user.level = Int32(arc4random_uniform(20))
        user.name = "张小猪\(arc4random_uniform(10))"
        user.iconUrl = "头像头像\(arc4random_uniform(2))"
        return user
    }()
    
    init(addr : String, port : Int) {
        client = TCPClient(addr: addr, port: port)
    }
}

extension LJSocket {
    func connectServe(timeout t : Int) -> Bool {
        isConnected = true
        return client.connect(timeout: t).0
    }
    
    func readMessage() {
        DispatchQueue.global().async {
            while self.isConnected {
                guard let lengthMsg = self.client.read(4) else { continue }
                let msgData = Data(bytes: lengthMsg, count: 4)
                var actualMsgLength = 0
                (msgData as NSData).getBytes(&actualMsgLength, length: 4)
                
                guard let typeMsg = self.client.read(2) else {
                    return
                }
                
                let typeData = Data(bytes: typeMsg, count: 2)
                var type = 0
                (typeData as NSData).getBytes(&type, length: 2)
                
                
                guard let actualMsg = self.client.read(actualMsgLength) else {
                    return
                }
                
                let actualMsgData = Data(bytes: actualMsg, count: actualMsgLength)
                
                DispatchQueue.main.async {
                    self.handleMsg(type, msgData: actualMsgData)
                }
                
            }
        }
    }
    
    
    fileprivate func handleMsg(_ type : Int, msgData : Data) {
        switch type {
        case 0:
            let user = try! UserInfo.parseFrom(data: msgData)
            delegate?.socket(self, enterRoom: user)
        case 1:
            let user = try! UserInfo.parseFrom(data: msgData)
            delegate?.socket(self, leaveRoom: user)
        case 2:
            let chatMsg = try! ChatMessage.parseFrom(data: msgData)
            delegate?.socket(self, textMsg: chatMsg)
        case 3:
            let giftMsg = try! GiftMessage.parseFrom(data: msgData)
            delegate?.socket(self, giftMsg: giftMsg)
        default:
            print("其他类型消息")
        }
    }
    
}


// 发送不同种类的消息
extension LJSocket {
    func sendEnterRoom() {
        let msgData = (try! user.build()).data()
        sendMsg(type: MessageType.enterRoomMessage, data: msgData)
    }
    
    func sendLeaveRoom() {
        let msgData = (try! user.build()).data()
        sendMsg(type: MessageType.leaveRoomMessage, data: msgData)
    }
    
    func sendTextMsg(_ text : String) {
        let chatMsg = ChatMessage.Builder()
        chatMsg.text = text
        chatMsg.user = try! user.build()
        let chatData = (try! chatMsg.build()).data()
        sendMsg(type: MessageType.textMessage, data: chatData)
    }
    
    func sendGiftMsg(_ giftName: String, giftUrlStr: String, giftCount: Int) {
        let giftMsg = GiftMessage.Builder()
        giftMsg.user = try! user.build()
        giftMsg.giftname = giftName
        giftMsg.giftUrl = giftUrlStr
        giftMsg.giftcount = Int32(giftCount)
        let giftData = (try! giftMsg.build()).data()
        sendMsg(type: MessageType.giftMessage, data: giftData)
    }
    
    func sendHeartBeat() {
        let msgData = "heart".data(using: .utf8)!
        sendMsg(type: MessageType(rawValue: 100)!, data: msgData)
    }
    
    
    func sendMsg(type : MessageType, data : Data) {
        var length = data.count
        let headData = Data(bytes: &length, count: 4)
        
        var msgType = type.rawValue
        let typeData = Data(bytes: &msgType, count: 2)
        
        let totalData = headData + typeData + data
        client.send(data: totalData)
    }
}















