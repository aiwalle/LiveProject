//
//  LJGiftAnimationModel.swift
//  LiveProject
//
//  Created by liang on 2017/9/2.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJGiftAnimationModel: NSObject {
    var senderName : String = ""
    var senderURL : String = ""
    var giftName : String = ""
    var giftURL : String = ""
    
    init(senderName : String, senderURL : String, giftName : String, giftURL : String) {
        self.senderName = senderName
        self.senderURL = senderURL
        self.giftName = giftName
        self.giftURL = giftURL
    }
    
    // 重写isEqual方法来判断两个对象是否相同
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? LJGiftAnimationModel else {
            return false
        }
        guard object.giftName == giftName && object.senderName == senderName else {
            return false
        }
        return true
    }
}
