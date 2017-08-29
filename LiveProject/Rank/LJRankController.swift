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
        
        let btn = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 0, y: 100, width: 70, height: 40)
        btn.backgroundColor = UIColor.red
        btn.setTitle("测试", for: UIControlState.normal)
        btn.addTarget(self, action: #selector(btnClick), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)
    }

    func btnClick() {
        navigationController?.pushViewController(LJRoomController(), animated: true)
    }

}
