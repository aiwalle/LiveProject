//
//  LJSubrankViewController.swift
//  LiveProject
//
//  Created by liang on 2017/10/26.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJSubrankViewController: UIViewController {

    fileprivate var typeName: String = ""
    
    var currentIndex: Int = 0 {
        didSet {
            switch currentIndex {
            case 0:
                typeName = "rankStar"
            case 1:
                typeName = "rankWealth"
            case 2:
                typeName = "rankPopularity"
            case 3:
                typeName = "rankStar"
            case 3:
                typeName = "rankAll"
            default:
                print("错误类型")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension LJSubrankViewController {
    func setupSubrankUI(_ titles: [String]) {
        let pageRect = CGRect(x: 0, y: 0, width: kDeviceWidth, height: kDeviceHeight-kNavigationBarHeight-kStatusBarHeight-kTabBarHeight)
        let titles = titles
        var style = LJPageStyle()
        style.normalColor = UIColor(r: 0, g: 0, b: 0)
        style.isScrollEnable = false
        style.titleHeight = 35
        style.titleBgColor = .white
        
        var childVcs = [LJDetailRankViewController]()
        for i in 0..<titles.count {
            let rankType = LJRankType(typeName: typeName, typeNum: i+1)
            let vc = currentIndex != 3 ? LJDetailRankViewController(rankType: rankType) : LJWeeklyRankViewController(rankType: rankType)
            childVcs.append(vc)
        }
        let pageView = LJPageView(frame: pageRect, titles: titles, style: style, childVcs: childVcs, parentVc: self)
        view.addSubview(pageView)
    }
}
