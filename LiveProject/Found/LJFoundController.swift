//
//  LJFoundController.swift
//  LiveProject
//
//  Created by liang on 2017/7/28.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJFoundController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = .white
        
        
        let collectionFrame = CGRect(x: 0, y: 80, width: view.bounds.width, height: 200)
        let titles = ["推荐", "游戏推荐", "娱乐推", "天天"]
        var style = LJPageStyle()
        style.isShowBottomLine = true
        let pageCv = LJPageCollectionView(frame: collectionFrame, titles: titles, style: style, isTitleInTop: true)
        
        view.addSubview(pageCv)
    }

    

}
