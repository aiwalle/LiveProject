//
//  LJSocketManager.swift
//  LiveProject
//
//  Created by liang on 2017/8/28.
//  Copyright © 2017年 liang. All rights reserved.
//

import Cocoa

class LJSocketManager : NSObject {
    fileprivate lazy var server : TCPServer = TCPServer(addr: "0.0.0.0", port : 9999)
    fileprivate var isServeRunning : Bool = false
    fileprivate lazy var clientMgrArr = [LJClientManager]()
    
}

extension LJSocketManager {
    func startRunning() {
        server.listen()
        isServeRunning = true
        DispatchQueue.global().async {
            while(self.isServeRunning) {
                if let client = self.server.accept() {
                    DispatchQueue.global().async {
                        self.dealClients(client: client)
                    }
                }
            }
        }
    }
    
    
    func stopRunning() {
        isServeRunning = false
    }
}


extension LJSocketManager {
    fileprivate func dealClients(client : TCPClient) {
        let clientMgr = LJClientManager(client : client)
        
        clientMgr.delegate = self
        clientMgrArr.append(clientMgr)
        clientMgr.readMessage()
    }
}

extension LJSocketManager : LJClientManagerDelegate {
    func sendMsgToClient(_ data: Data) {
        for mgr in clientMgrArr {
            mgr.client.send(data: data)
        }
    }
    
    func removeClient(client: LJClientManager) {
        guard let index = clientMgrArr.index(of: client) else { return }
        clientMgrArr.remove(at: index)
    }
}




