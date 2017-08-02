//
//  LJNavigationCotroller.swift
//  LiveProject
//
//  Created by liang on 2017/8/2.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJNavigationCotroller: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 全屏Pop
        
        // 通过运行时获取到gesture对应的target和action
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let nameP = ivar_getName(ivar)
            let name = String(cString: nameP!)
            print(name)
        }
        
        
        guard let interactive = interactivePopGestureRecognizer else {
            return
        }
        
//        let panGes = UIPanGestureRecognizer(target: <#T##Any?#>, action: <#T##Selector?#>)
//        
//        view.addGestureRecognizer(interactive)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }

    

}
