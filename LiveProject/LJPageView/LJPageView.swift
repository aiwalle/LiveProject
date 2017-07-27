//
//  LJPageView.swift
//  LiveProject
//
//  Created by liang on 2017/7/25.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJPageView: UIView {
    var titles : [String]
    var style : LJPageStyle
    var childVcs : [UIViewController]
    var parentVc : UIViewController
    
    // super之前必须保证初始化了
    init(frame: CGRect, titles: [String], style: LJPageStyle, childVcs: [UIViewController], parentVc: UIViewController) {
        self.titles = titles
        self.style = style
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



extension LJPageView {
    fileprivate func setupUI() {
        let titleFrame = CGRect(x: 0, y: 0, width: bounds.width, height: style.titleHeight)
        let titleView = LJTitleView(frame: titleFrame, titles: titles, style: style)
        titleView.backgroundColor = UIColor(hexString: "0000FF")
        addSubview(titleView)
        
        let contentFrame = CGRect(x: 0, y: style.titleHeight, width: bounds.width, height: bounds.height - style.titleHeight)
        let contentView = LJContentView(frame: contentFrame, childVcs: childVcs, parentVc: parentVc)
        contentView.backgroundColor = .blue
        addSubview(contentView)
        
        titleView.delegate = contentView
        contentView.delegate = titleView
        
    }
}






