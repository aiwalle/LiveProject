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
    var normalColor : UIColor = .black
    var selectColor : UIColor = .red
    var titleFont : UIFont = UIFont.systemFont(ofSize: 14.0)
    var isScrollEnable: Bool = false
    var titleMargin : CGFloat = 20.0
    var isShowBottomLine: Bool = false
    var bottomLineColor : UIColor = .orange
    var bottomLineHeight : CGFloat = 2.0
    var isNeedScale : Bool = false
    var maxScale : CGFloat = 1.2
    
    var coverViewColor : UIColor = .black
    var coverViewAlpha : CGFloat = 0.3
    var isShowCoverView : Bool = false
    var coverViewHeight : CGFloat = 25
    var coverViewRadius : CGFloat = 12
    var coverViewMargin : CGFloat = 8
    // 这里应该添加一个功能是根据传入titles的整体长度来判断是否滚动，而不是让用户来设置
}
