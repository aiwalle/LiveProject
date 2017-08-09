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
        view.backgroundColor = .white
        
        let emoView = EmoticonView.loadFromNib()
        
        view.addSubview(emoView)
        
        let gift = GiftView.loadFromNib()
        view.addSubview(gift)
        
        // 协议规定了遵守的类型，因此这里报错
//        let person = Person.loadFromNib()
        
    }

    

}
