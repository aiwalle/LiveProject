//
//  LJGiftViewModel.swift
//  LiveProject
//
//  Created by liang on 2017/8/11.
//  Copyright © 2017年 liang. All rights reserved.
//

import Foundation


// MARK:- 面向对象
//class LJGiftViewModel: NSObject {
//    lazy var giftPackages : [LJGiftPackage] = [LJGiftPackage]()
//}
//
//extension LJGiftViewModel {
//    func requestGiftData(_ completion : @escaping() -> Void) {
//        LJNetWorkManager.requestData(.get, URLString: "http://qf.56.com/pay/v4/giftList.ios", parameters: ["type" : 0, "page" : 1, "rows" : 150]) { (result : Any) in
//            guard let resultDict = result as? [String : Any] else { return }
//            guard let typeDictData = resultDict["message"] as? [String : Any] else { return }
//            for i in 0..<typeDictData.count {
//                guard let typeDic = typeDictData["type\(i+1)"] as? [String : Any] else { continue }
//                self.giftPackages.append(LJGiftPackage(dict: typeDic))
//            }
//            self.giftPackages = self.giftPackages.filter({$0.t != 0}).sorted(by: {$0.t > $1.t})
//            completion()
//        }
//    }
//}


// MARK:- 面向协议
class LJGiftViewModel: NSObject, Requestable {
    var URLString: String = "http://qf.56.com/pay/v4/giftList.ios"
    var type: MethodType = .get
    var parameters: [String : Any] = ["type" : 0, "page" : 1, "rows" : 150]
    typealias ResultData = [LJGiftPackage]
    var data: [LJGiftPackage] = []
}

extension LJGiftViewModel {
    func parseResult(_ result: Any) {
        guard let resultDict = result as? [String : Any] else { return }
        guard let typeDictData = resultDict["message"] as? [String : Any] else { return }
        for i in 0..<typeDictData.count {
            guard let typeDic = typeDictData["type\(i+1)"] as? [String : Any] else { continue }
            self.data.append(LJGiftPackage(dict: typeDic))
        }
        self.data = self.data.filter({$0.t != 0}).sorted(by: {$0.t > $1.t})
    }
}






