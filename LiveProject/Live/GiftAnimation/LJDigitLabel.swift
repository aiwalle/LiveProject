//
//  LJDigitLabel.swift
//  LiveProject
//
//  Created by liang on 2017/9/1.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJDigitLabel: UILabel {

    override func drawText(in rect: CGRect) {
        let oldColor = textColor
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(5)
        context?.setLineJoin(.round)
        context?.setTextDrawingMode(.stroke)
        textColor = UIColor.red
        super.drawText(in: rect)
        
        context?.setTextDrawingMode(.fill)
        textColor = oldColor
        shadowOffset = CGSize.zero
        super.drawText(in: rect)
    }
    
    func showDigitAnimation(_ duration : TimeInterval, _ completion: @escaping () -> ()) {
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: [], animations: { 
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: { 
                self.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: { 
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            })
        }) { (isFinished) in
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: [], animations: { 
                self.transform = CGAffineTransform.identity
            }, completion: { (isFinished) in
                completion()
            })
        }
    }
 

}
