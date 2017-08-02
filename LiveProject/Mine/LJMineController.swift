//
//  LJMineController.swift
//  LiveProject
//
//  Created by liang on 2017/7/28.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

class LJMineController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        startEmittering()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        startEmittering()
        stopEmittering()
    }

    
    func startEmittering() {
        // 粒子动画
        let emmiter = CAEmitterLayer()
        emmiter.emitterPosition = CGPoint(x: view.bounds.width * 0.5, y: view.bounds.height * 0.5)
        emmiter.preservesDepth = true
        
        var cells = [CAEmitterCell]()
        
        for i in 0..<10 {
            let cell = CAEmitterCell()
            cell.birthRate = 10
            cell.lifetime = 3
            cell.lifetimeRange = 2
            cell.scale = 0.7
            cell.scaleRange = 0.2
            cell.emissionLongitude = CGFloat(-Double.pi / 2)
            cell.emissionRange = CGFloat(Double.pi / 12)
            cell.velocity = 50
            cell.velocityRange = 20
            cell.contents = UIImage(named: "good\(i)_30x30")?.cgImage
            cell.birthRate = 2
            cell.spin = CGFloat(.pi / 2.0)
            cell.spinRange = CGFloat(.pi / 4.0 )
            
            cells.append(cell)
        }
        emmiter.emitterCells = cells
        view.layer.addSublayer(emmiter)
        
    }
    
    func stopEmittering() {
        /*
         for layer in view.layer.sublayers! {
         if layer.isKind(of: CAEmitterLayer.self) {
         layer.removeFromSuperlayer()
         }
         }
         */
        view.layer.sublayers?.filter({ $0.isKind(of: CAEmitterLayer.self)}).first?.removeFromSuperlayer()
    }
    

}
