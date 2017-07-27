//
//  LJPageStyle.swift
//  LiveProject
//
//  Created by liang on 2017/7/25.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

struct LJPageStyle {
    var titleHeight : CGFloat = 44
    var normalColor : UIColor = UIColor(r: 255, g: 255, b: 255)
    var selectColor : UIColor = UIColor(r: 255, g: 127, b: 0)
    var titleFont : UIFont = UIFont.systemFont(ofSize: 14.0)
    var isScrollEnable: Bool = false
    var titleMargin : CGFloat = 20.0
    var isShowBottomLine: Bool = true
    var bottomLineColor : UIColor = .orange
    var bottomLineHeight : CGFloat = 2.0
    var isNeedScale : Bool = false
    var maxScale : CGFloat = 1.2
}
