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
        
        navigationBar.barTintColor = UIColor.black
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
//            navigationBar.barTintColor = .white
            
            setupCustomBackButtonItem(viewController)
        }
        
        super.pushViewController(viewController, animated: animated)
    }

    
    override func popViewController(animated: Bool) -> UIViewController? {
//        if self.childViewControllers.count < 3 {
//            navigationBar.barTintColor = .black
//        }
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

extension LJNavigationCotroller {
    fileprivate func setupCustomBackButtonItem(_ viewController: UIViewController) {
        let backBtn = UIButton(type: .custom)
        backBtn.setTitle("返回", for: .normal)
        backBtn.setTitleColor(.white, for: .normal)
        backBtn.setImage(UIImage(named: "back"), for: .normal)
        backBtn.sizeToFit()
        backBtn.addTarget(self, action: #selector(backButtonItemClick), for: .touchUpInside)
        backBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
    }
    
    @objc fileprivate func backButtonItemClick() {
        if self.childViewControllers.count <= 1{
            
        } else {
            _ = self.popViewController(animated: true)
        }
    }
}
