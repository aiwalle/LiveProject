//
//  LJGiftAnimationController.swift
//  LiveProject
//
//  Created by liang on 2017/10/26.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJGiftAnimationController: UIViewController {
    
    var label : LJDigitLabel!
    
    fileprivate lazy var giftContainerView : LJGiftContainerView = LJGiftContainerView(frame: CGRect(x: 0, y: 100, width: 250, height: 100))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //        let btn = UIButton(type: UIButtonType.custom)
        //        btn.frame = CGRect(x: 0, y: 100, width: 70, height: 40)
        //        btn.backgroundColor = UIColor.red
        //        btn.setTitle("测试", for: UIControlState.normal)
        //        btn.addTarget(self, action: #selector(btnClick), for: UIControlEvents.touchUpInside)
        //        view.addSubview(btn)
        //
        //
        //
        //        let label = LJDigitLabel(frame: CGRect(x: 50, y: 200, width: 200, height: 80))
        //        label.textColor = UIColor.green
        //        self.label = label
        //        label.text = "哈啊哈哈哈哈"
        //        view.addSubview(label)
        
        
        let btn1 = UIButton(type: .custom)
        btn1.frame = CGRect(x: 0, y: 410, width: 60, height: 40)
        btn1.backgroundColor = .red
        btn1.addTarget(self, action: #selector(btnClick1), for: .touchUpInside)
        
        let btn2 = UIButton(type: .custom)
        btn2.backgroundColor = .red
        btn2.frame = CGRect(x: 70, y: 410, width: 60, height: 40)
        btn2.addTarget(self, action: #selector(btnClick2), for: .touchUpInside)
        
        let btn3 = UIButton(type: .custom)
        btn3.backgroundColor = .red
        btn3.frame = CGRect(x: 150, y: 410, width: 60, height: 40)
        btn3.addTarget(self, action: #selector(btnClick3), for: .touchUpInside)
        
        view.addSubview(btn1)
        view.addSubview(btn2)
        view.addSubview(btn3)
        view.addSubview(self.giftContainerView)
        self.giftContainerView.backgroundColor = UIColor.blue
        
        
        
        
    }
    
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        self.label.showDigitAnimation(2.0) {
    //            print("完成完成")
    //        }
    //    }
    
    @objc func btnClick1() {
        //        navigationController?.pushViewController(LJRoomController(), animated: true)
        
        let gif = LJGiftAnimationModel(senderName: "哈哈", senderURL: "", giftName: "baidu", giftURL: "https://www.baidu.com/img/bd_logo1.png")
        self.giftContainerView.showGiftModel(gif)
    }
    
    @objc func btnClick2() {
        //        navigationController?.pushViewController(LJRoomController(), animated: true)
        
        let gif = LJGiftAnimationModel(senderName: "大牛", senderURL: "", giftName: "心心", giftURL: "http://images.missyuan.com/attachments/day_100104/20100104_a9239b7563cdd1350bd8sOsG3Co212Gn.png")
        self.giftContainerView.showGiftModel(gif)
    }
    
    @objc func btnClick3() {
        //        navigationController?.pushViewController(LJRoomController(), animated: true)
        
        let gif = LJGiftAnimationModel(senderName: "小芳", senderURL: "", giftName: "问号", giftURL: "http://www.lanrentuku.com/down/png/0905/17Button/Button-Help.png")
        self.giftContainerView.showGiftModel(gif)
    }
    
}
