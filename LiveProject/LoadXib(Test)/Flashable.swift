//
//  Flashable.swift
//  LiveProject
//
//  Created by liang on 2017/8/10.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit


protocol Flashable {
    
}

// 可以拓展系统的协议
extension Flashable where Self : UIView {
    func flash() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1.0
        }) { (isFinished) in
            UIView.animateKeyframes(withDuration: 0.25, delay: 2.0, options: [], animations: {
                self.alpha = 0
            }, completion: nil)
        }
    }
}
