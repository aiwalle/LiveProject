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
        
        
        // 通过运行时获取到gesture对应的target和action
        /*
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let nameP = ivar_getName(ivar)
            let name = String(cString: nameP!)
        }
        */
        
        // 全屏Pop
        guard let value = interactivePopGestureRecognizer?.value(forKeyPath: "_targets") as? [NSObject] else {
            return
        }
        guard let objc = value.first else {
            return
        }
        let target = objc.value(forKeyPath: "target")
        let action = Selector(("handleNavigationTransition:"))
        
        let panGes = UIPanGestureRecognizer(target: target, action: action)
        panGes.delegate = self
        view.addGestureRecognizer(panGes)
        
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            navigationBar.barTintColor = .white
        }
        
        super.pushViewController(viewController, animated: animated)
    }

    
    override func popViewController(animated: Bool) -> UIViewController? {
        if self.childViewControllers.count < 3 {
            navigationBar.barTintColor = .black
        }
        return super.popViewController(animated: animated)
    }
    

}

extension LJNavigationCotroller : UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.childViewControllers.count > 1 {
            return true
        }
        return false
    }
}
