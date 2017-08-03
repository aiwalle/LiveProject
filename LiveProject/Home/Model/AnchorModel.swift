//
//  AnchorModel.swift
//  LiveProject
//
//  Created by liang on 2017/8/3.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class AnchorModel: BaseModel {
    var uid : String = ""
    var roomid : Int = 0
    var name : String = ""
    var pic51 : String = ""
    var pic74 : String = ""
    var live : Int = 0 // 是否在直播
    var push : Int = 0 // 直播显示方式
    var focus : Int = 0 // 关注数
    
    var isEvenIndex : Bool = false
}
