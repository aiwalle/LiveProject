//
//  UIColor-Extension.swift
//  LiveProject
//
//  Created by liang on 2017/7/26.
//  Copyright © 2017年 liang. All rights reserved.
//

import UIKit

extension UIColor {
    // 获取随机颜色
    class func getRandomColor() -> UIColor{
        return UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1.0)
    }
    
    // 便利构造器（有参数一般使用构造函数）
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    convenience init?(hexString: String) {
        guard hexString.characters.count >= 6 else {
            return nil
        }
        var hexTempString = hexString.uppercased()
        if hexTempString.hasPrefix("0X") || hexTempString.hasPrefix("##") {
            hexTempString = (hexTempString as NSString).substring(from: 2)
        }
        
        if hexTempString.hasPrefix("#") {
            hexTempString = (hexTempString as NSString).substring(from: 1)
        }
        var range = NSRange(location: 0, length: 2)
        let redHex = (hexTempString as NSString).substring(with: range)
        range.location = 2
        let greenHex = (hexTempString as NSString).substring(with: range)
        range.location = 4
        let blueHex = (hexTempString as NSString).substring(with: range)
        var r: UInt32 = 0
        var g: UInt32 = 0
        var b: UInt32 = 0
        Scanner(string: redHex).scanHexInt32(&r)
        Scanner(string: greenHex).scanHexInt32(&g)
        Scanner(string: blueHex).scanHexInt32(&b)
        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    }
    
}
