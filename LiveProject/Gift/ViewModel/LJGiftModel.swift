//
//  LJGiftModel.swift
//  LiveProject
//
//  Created by liang on 2017/8/11.
//  Copyright © 2017年 liang. All rights reserved.
//

import Foundation

class LJGiftModel: BaseModel {
    var img2 : String = "" // 图片
    var coin : Int = 0 // 价格
    var subject : String = "" { // 标题
        didSet {
            if subject.contains("(有声)") {
                subject = subject.replacingOccurrences(of: "(有声)", with: "")
            }
        }
    }
}
