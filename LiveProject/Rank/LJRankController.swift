//
//  LJRankController.swift
//  LiveProject
//
//  Created by liang on 2017/7/28.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJRankController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pageRect = CGRect(x: 0, y: 20, width: kDeviceWidth, height: kDeviceHeight - 20)
        let titles = ["明星榜", "富豪榜", "人气榜", "周星榜"]
        var style = LJPageStyle()
        style.normalColor = .white
        style.isScrollEnable = false
        style.isShowBottomLine = true
        var childVcs = [LJSubrankViewController]()
        for i in 0..<titles.count {
            let vc: LJSubrankViewController = i == 3 ? LJWeekrankViewController() : LJNormalRankViewController()
            vc.currentIndex = i
            childVcs.append(vc)
        }
        let pageView = LJPageView(frame: pageRect, titles: titles, style: style, childVcs: childVcs, parentVc: self)
        view.addSubview(pageView)
        
    }
}
