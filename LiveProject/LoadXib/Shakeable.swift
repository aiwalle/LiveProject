//
//  Shakeable.swift
//  LiveProject
//
//  Created by liang on 2017/8/10.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit


protocol Shakeable {
    
}

extension Shakeable where Self : UIView {
    func shake() {
        let shakeAnim = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnim.values = [-8, 0, 8, 0]
        shakeAnim.duration = 0.1
        shakeAnim.repeatCount = 5
        layer.add(shakeAnim, forKey: nil)
    }
}
