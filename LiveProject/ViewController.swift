//
//  ViewController.swift
//  LiveProject
//
//  Created by liang on 2017/7/25.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        let pageFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
//        let titles = ["推荐", "游戏推荐", "娱乐推", "天天"]
        let titles = ["推荐", "游戏推荐", "娱乐推", "哈哈哈哈哈荐","呵呵呵", "科技推", "娱乐推荐推荐"]
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.getRandomColor()
            childVcs.append(vc)
        }
        var style = LJPageStyle()
        style.isShowBottomLine = true
        style.isShowCoverView = true
        style.isScrollEnable = true
        style.isNeedScale = true
        let pageView = LJPageView(frame: pageFrame, titles: titles, style: style, childVcs: childVcs, parentVc: self)
        view.addSubview(pageView)
    }


}

